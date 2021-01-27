/* question v : la probabilité que i espèces survivent est non linéaire */

/* Paramètres */
int m = ...;
int n = ...;
int p = ...;
int q = ...;


int i;
int j;
range h = 1..n;

range w = 1..m;

/*nombre d'espèces d'animaux*/
range sp = 1..(p+q);

range rare = 1..p;

range common = (p+1)..(p+q);

float alpha[sp] = ...;

float proba[sp][h][w] = ...;

int c[h][w] = ...;

/* probalème */
dvar boolean prot[h][w];

dvar boolean central[h][w];

dvar int cost;

minimize cost;

subject to {
  cost ==  sum(i in h) sum(j in w) prot[i][j]*c[i][j];

  /* contrainte bord première et dernière colonnes */
  sum(i in h) central[i][1] == 0;
  sum(i in h) central[i][m] == 0;
  
  /* ligne */
  sum(j in w) central[1][j] == 0;
  sum(j in w) central[n][j] == 0;

  /* carré */
  forall(i in 2..(n-1)) 
    forall(j in 2..(m-1)) 
      9*central[i][j] <= 
        sum(x in (i-1)..(i+1)) sum(y in (j-1)..(j+1)) prot[x][y];

  /* zoli nanimo */
  forall(s in rare) 
    sum(i in h) sum(j in w)
      log(1-proba[s][i][j])*central[i][j] <= log(1-alpha[s]);

  /* zanimo pabo */
  forall(s in common) 
    sum(i in h) sum(j in w)
      log(1-proba[s][i][j])*prot[i][j] <= log(1-alpha[s]);
}

main {
  thisOplModel.generate();
  cplex.solve();
  thisOplModel.postProcess();
}

execute DISPLAY {
  write("\ncoûtcoût:");
  write(cost);
  write("\n");
  write("\n");
  write("Estimated survival probability of animal kingdom\n");
  for(var s in sp){
    var res=1;
    for(var x in h){
      for(var y in w){
        if(s <= p){
          res = res*(1-proba[s][x][y]*central[x][y]);
        }
        else{
          res = res*(1-proba[s][x][y]*prot[x][y]);
        }
      }
    }
    write(s);
    write(": ");
    write(1-res);
    write("\n");
  }

  write("\n\n");

  for(var i in h){
    for(var j in w){
      if(central[i][j]==1){
        write(2);
      }
      else {
        if(prot[i][j]==1){
          write(1);
        }
        else {
          write(0);
        }
      }
    }
    write("\n");
  }
  write("\n");
}
