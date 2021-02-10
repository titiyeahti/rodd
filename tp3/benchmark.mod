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
range decoup = 1..T;

int individu[tot][chrom][gen][1..2] = ...;

/* proba que l'allèle survive à l'accouplement entre deux individus */
float proba[chrom][gen][alel][father][mother];


execute COMPUTE_P { 
  for (var c in chrom) {
    for (var g in gen) {
      for (var a in alel) {
        for (var f in father) {
          for (var m in mother) {

            cf = 0;
            cm = 0;

            for (var i in 1..2){
              if (individu[f][c][gen][i] != a){
                cf ++;
              }
              if (individu[m][c][gen][i] != a){
                cm ++;
              }
            }

            /* tous les allèles du père ou de la mère sont celui que l'on cherche 
               => proba que a disparaisse = 0 */
            if (cf == 0 || cm == 0){
              p[c][g][a][f][m] = 1.;
            }
            else { 
              if (cf + cm == 2){
                p[c][g][a][f][m] = 3./4;
              }
              if (cf + cm == 3){
                p[c][g][a][f][m] = 1./2;
              }
              if (cf + cm == 4){
                p[c][g][a][f][m] = 0.;
              }
            }
          }
        }
      }
    }
  }
}


dvar int x[tot];
dvar boolean tuple[tot][father][mother];
dvar t[cga]

sum a
  proba disparition de chacune des allèles 

P(cga) = prod (i in individus #a = 1) (1/2)^(x[i]) 
  ou 0 si il esxits i tq #a = 2 et x[i] > 0

P(cga) >= 0
P(cga) >= t[cga] -  sum(i in tot st #a = 2) x[i] 

log(t[cga]) >= log(prod (i in individus #a = 1) (1/2)^(x[i]))
  => approximation linéaire par morceaux.

minimize
  /* E[x_d] */
  sum(c in chrom)
    sum(g in gen)
      sum(a in alel) 
  /*  log( 1 + 
        prod(i in tot) 
          prod(f in father)
            prod(m in mother) 
              /* proba vie */
              1 - tuple[i][f][m]*proba[c][g][a][f][m]/2 
        )
*/
  /* sum (i in 1..C*G*A) p_i */
  /* sum (i in 1..C*G*A) log(p_i) */
        sum(i in tot) 
          sum(f in father)
            sum(m in mother) 
              /* proba vie */
              tuple[i][f][m]*log(1 - proba[c][g][a][f][m])
    
              

subject to {
  /* il faut N enfant en tout
    => les pères doivent avoir N enfants
    => idem pour les mères*/
  sum(i in mother) x[i] = N;
  sum(i in father) x[i] = N;

  /* lien entre x et tuple */
  forall (f in father)
    sum(m in mother)
      sum(i in tot) tuple[i][f][m] == x[f];
  
  /* lien entre x et tuple */
  forall (m in mother)
    sum(f in father)
      sum(i in tot) tuple[i][f][m] == x[m];
  
  /* un papa une maman */
  forall (i in tot)
    sum (f in father) 
      sum (m in father)
        tuple[i][f][m] == 1;
}


