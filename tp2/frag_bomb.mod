int m = ...;
int n = ...;
int B = ...;
int Amin = ...;
int Amax = ...;

range h = 1..m;
range w = 1..n;

int c[h][w] = ...;

float lambda = ...;


dvar boolean x[h][w];
dvar boolean nearest[h][w][h][w];

float dist[h][w][h][w];

execute DIDIER {
  for(var i1 in h){
    for(var j1 in w){
      for(var i2 in h){
        for(var j2 in w){
          dist[i1][j1][i2][j2] = Math.sqrt(
              (i1-i2)*(i1-i2) + (j1-j2)*(j1-j2));
        }
      }
    }
  }
}

dvar float v;
dvar float f;
dvar float g;

minimize f-lambda*g;

subject to {
  /* definition des fonctions */
  f == sum(i1 in h) sum(j1 in w) 
    sum(i2 in h) sum(j2 in w : j2!=j1 || i1 != i2)
      dist[i1][j1][i2][j2]*nearest[i1][j1][i2][j2];

  g == sum(i in h) sum(j in w) x[i][j];

  /* aire */
  sum(i in h) sum(j in w) x[i][j] <= Amax;
  sum(i in h) sum(j in w) x[i][j] >= Amin;

  /* coût */
  /* facteur 10 pour trouver les bons résultats car nous possédons un cerveau nitro boosté par l'absence de vaccins #etMercéMrVerran .*/
  sum(i in h) sum(j in w) 10* x[i][j] * c[i][j] <= B;

  /* plus proche != de lui-même */
  sum(i in h) sum(j in w) nearest[i][j][i][j] == 0;

  /* destination doit exister */
  forall(i1 in h) forall(j1 in w)
    forall(i2 in h) forall(j2 in w)
      nearest[i1][j1][i2][j2] <= x[i2][j2];

  /* origine doit exister */
  forall(i1 in h) forall(j1 in w)
    sum(i2 in h) sum(j2 in w)
      nearest[i1][j1][i2][j2] == x[i1][j1];
}

main {
  nbiter = 1;
  write("\n\n");
  write("########### ITER");
  write(nbiter);
  write(" ###########\n\n");
  
  thisOplModel.generate();
  cplex.solve();
  thisOplModel.postProcess();
  cf = thisOplModel.f;
  cg = thisOplModel.g;
  
  while(cf - thisOplModel.lambda*cg < 0){
		nbiter++;
    write("\n\n");
    write("########### ITER");
    write(nbiter);
    write(" ###########\n\n");
    lambda = cf/cg;
		
		var sub = new IloOplDataElements();
		var master = thisOplModel;
		
		sub.m = master.m;
		sub.n = master.n;
		sub.B = master.B;
		sub.Amin = master.Amin;
		sub.Amax = master.Amax;
		sub.c = master.c;
		sub.lambda = lambda;
		
		var res = thisOplModel.modelDefinition;
		thisOplModel = new IloOplModel(res,cplex);
		thisOplModel.addDataSource(sub);
		
    thisOplModel.generate();
		cplex.solve();
		thisOplModel.postProcess();
    
    cf = thisOplModel.f;
    cg = thisOplModel.g;
	}
}

execute DISPLAY{
  
  write("\n");
  write("x: \n");

  for(var i in h){
    for(var j in w){
      write(x[i][j]);
      write(" ");
    }
    write("\n");
  }

  write("\n");
  write("f: ");
  write(f);

  write("\n");
  write("g: ");
  write(g);

  write("\n");
  write("v: ");
  write(f-lambda*g);
  
  write("\n");
  write("f/g: ");
  write(f/g);
  write("\n\n");
}
