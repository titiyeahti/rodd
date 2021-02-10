
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
dvar float d[H][W];

maximize w1 * (sum(i in h) sum(j in w) t[i][j]*(1-x[i][j]))
  + w2 * g * L * sum(i in h) sum(j in w) (
      4*x[i][j] - d[i][j]);

subject to {
  /* un 1 dans matrice sur la diagonale pour les x en bordure 
     => pas important */
  forall (i in h) x[i][m+1] == 0;
  forall (j in w) x[n+1][j] == 0;
  forall (i in h) x[i][0] == 0;
  forall (j in w) x[0][j] == 0;

  forall (i in h)
    forall (j in w){
      d[i][j] >= - 4*(1-x[i][j]) + 
        x[i+1][j] +
        x[i-1][j] +
        x[i][j+1] +
        x[i][j-1];
      d[i][j] >= 0;
    }
}

main {
  thisOplModel.generate();
  cplex.solve();
  thisOplModel.postProcess();
}

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
