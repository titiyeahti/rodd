
int P=...;
int m=...;
int n=...;
float w1=...;
float w2=...;
float L=...;
float g=...;

range h = 1..n;
range w = 1..m;

range H = 0..(n+1);
range W = 0..(m+1);

int t[h][w] = ...; 

dvar boolean x[H][W];
dvar float y[H][W][H][W];

maximize w1 * (sum(i in h) sum(j in w) t[i][j]*(1-x[i][j]))
  + w2 * g * L * sum(i in h) sum(j in w) (
      4*x[i][j] -(
      y[i][j][i+1][j] +
      y[i][j][i-1][j] +
      y[i][j][i][j+1] +
      y[i][j][i][j-1])
  );

subject to {
  /* un 1 dans matrice sur la diagonale pour les x en bordure 
     => pas important */
  forall (i in h) x[i][m+1] == 0;
  forall (j in w) x[n+1][j] == 0;
  forall (i in h) x[i][0] == 0;
  forall (j in w) x[0][j] == 0;

  //sum(i in h) sum(j in w) x[i][j] >= 60;

  /* multiplication dans le groupe {0,1} */
  forall (i in h)
    forall (j in w) {
      y[i][j][i+1][j] >= x[i][j] + x[i+1][j] - 1;
      y[i][j][i-1][j] >= x[i][j] + x[i-1][j] - 1;
      y[i][j][i][j+1] >= x[i][j] + x[i][j+1] - 1;
      y[i][j][i][j-1] >= x[i][j] + x[i][j-1] - 1;
    }

  forall (i in H)
    forall (j in W)
      forall (k in H)
        forall (l in W)
          y[i][j][k][l] >= 0;


  /* contrainte de positivité de y et x \in [0,1] pour la 
   relaxation */
}

float timing;

main {
  var before = new Date();
  timing = before.getTime();
  thisOplModel.generate();
  cplex.solve();
  thisOplModel.postProcess();
  var after = new Date();
  timing = after.getTime() - timing;
  writeln("##", thisOplModel.n," ", timing);
}

/*
execute SUPREME_DISPLAY_OF_TALENT {
  write("Plan de coupe :");
  write("\n");
  for(var i in h){
    for(var j in w){
      write(x[i][j]);
      write(" ");
    }
    write("\n");
  }
}
*/
