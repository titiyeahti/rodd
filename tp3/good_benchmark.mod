int N = ...;
int Nm = ...;
int Nf = ...;
int C = ...;
int G = ...;
int A = ...;
int T = ...;

float init = ...;

range tot = 1..N;
range father = 1..Nm;
range mother = (Nm+1)..(Nf+Nm);
range chrom = 1..C;
range gen = 1..G;
range alel = 1..A;
range decoup = 2..T;

float theta[1..T];

execute FILL_THETA{
  theta[1] = init;
  /*p = Math.pow(theta[1], -1./(T-1));*/
  for(var i in decoup){
    theta[i] = Math.pow(init, (T-i)/(T-1));
  }
}

int individu[tot][chrom][gen][1..2] = ...;

dvar int x[tot];
dvar float t[chrom][gen][alel];
dvar float p[chrom][gen][alel];

minimize
  sum (c in chrom) 
    sum (g in gen)
      sum (a in alel)
        p[c][g][a];

subject to {
  /* il faut N enfant en tout
    => les pères doivent avoir N enfants
    => idem pour les mères*/
  sum(i in mother) x[i] == N;
  sum(i in father) x[i] == N;

  forall(i in tot)
    x[i] <= 3;

  forall(i in tot)
    x[i] >= 0;

  forall(c in chrom)
    forall(g in gen)
      forall(a in alel)
        p[c][g][a] >= 0;

  forall(c in chrom)
    forall(g in gen)
      forall(a in alel)
        p[c][g][a] >= t[c][g][a] - 
          sum(i in tot : (individu[i][c][g][1] == a) && 
              (individu[i][c][g][2] == a)) x[i];

  forall(c in chrom)
    forall(g in gen)
      forall(a in alel)
        forall(r in 1..T)
          ln(theta[r]) + (t[c][g][a] - theta[r])/theta[r] >= 
            sum(i in tot : 
            ((individu[i][c][g][1] == a)||(individu[i][c][g][2] == a)) 
            && ((individu[i][c][g][1] != a)||(individu[i][c][g][2] != a)))
            x[i]*(-ln(2));
}

main {
  thisOplModel.generate();
  cplex.solve();
  thisOplModel.postProcess();
}

execute SUPREME_DISPLAY_OF_TALENT{
  write("\nNombre de gosses par personnes\n")
  for(var i in tot){
    write(x[i]);
    write(" ");
  }
  write("\n\n");
  write("Proba de disparitions des allèles\n");
  for(var c in chrom){
    for(var g in gen){
      write("\ngène: ");
      write(g);
      write("\n");
      for(var a in alel){
        write(p[c][g][a]); write(" ");
      }
    }
  }
  write("\n\n");
}

