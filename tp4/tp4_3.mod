
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

dvar float x[H][W];
dvar float y[H][W][1..4];
dvar float cost;

maximize cost;

/* Biparti : damier cases noires d'un côté et blanches de l'autre.
   preuve TU il suffit de numéroter les cases en serpent 
   puis de mettre les colonnes paires d'un côté et les impaires de l'autre.
 */


subject to {
  cost == w1 * (sum(i in h) sum(j in w) t[i][j]*(1-x[i][j]))
  + w2 * g * L * sum(i in h) sum(j in w) (
    4*x[i][j] - sum(k in 1..4) y[i][j][k]
  );
  /* un 1 dans matrice sur la diagonale pour les x en bordure 
     => pas important */
  forall (i in h) x[i][m+1] == 0;
  forall (j in w) x[n+1][j] == 0;
  forall (i in h) x[i][0] == 0;
  forall (j in w) x[0][j] == 0;

  /* multiplication dans le groupe {0,1} */
  forall (i in h)
    forall (j in w) {
      y[i][j][1] >= x[i][j] + x[i+1][j] - 1;
      y[i][j][2] >= x[i][j] + x[i-1][j] - 1;
      y[i][j][3] >= x[i][j] + x[i][j+1] - 1;
      y[i][j][4] >= x[i][j] + x[i][j-1] - 1;
    }

  /* contrainte de positivité de y et x \in [0,1] pour la 
   relaxation */
  forall (i in H)
    forall (j in W)
      forall (k in 1..4)
        y[i][j][k] >= 0;

  forall (i in H)
    forall (j in W){
      1 >= x[i][j];
      x[i][j] >= 0;
    }
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
  write("\nFonction économique: ");
  write(cost);
  write("\n");
}
*/
