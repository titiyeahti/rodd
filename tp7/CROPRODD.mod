int NbParcelles =...; //nombre de parcelles
range Parcelles =1..NbParcelles;
int T =...; //horizon de planification
range Periode=1..T;
int SURF=...;
int lmax= ...; // duree au-dela de laquelle prolonger la jachere n'ameliore plus le rendement
int amax= ...; //nombre max de de semestres de cultures
{int} C[1..2] = ...; //cultures en semestre pair/impair

int s[t in Periode]=(t%2==1)?1:2;

{int} Cultures=C[1] union C[2];

 int Demande[Cultures][Periode]=...;
 
 tuple sommet{
 int l; //age de la jachere
 int a; // age de la culture
 int j; //culture ou jachere en cours 
 }
 
 {sommet} Sommets=...;
 
 tuple arc {
sommet i; //extremite initiale
sommet f; //extremite finale
int rend;
}  
 
 {arc} Arcs=...;
 {arc} InitArc=
 {<<2,0,0>,<2,0,0>,0>,
 <<2,0,0>,<2,1,1>,120>
 };
 
 dvar boolean x[Arcs][Periode][Parcelles];

 minimize sum(p in Parcelles) sum(arc in InitArc) x[arc][1][p];

 subject to {
   forall(p in Parcelles){
     sum(arc in Arcs : arc not in InitArc) x[arc][1][p] == 0;
     sum(arc in InitArc) x[arc][1][p] <= 1;
   }

   forall(t in Periode){
     forall(j in C[s[t]]){
       sum(p in Parcelles) sum(arc in Arcs : arc.f.j == j) 
         x[arc][t][p]*arc.rend >= Demande[j][t];
     }
   }

   forall(t in 1..(T-1)){
     forall(p in Parcelles){
       forall(s in Sommets){
         sum(arc in Arcs : arc.i == s) x[arc][t+1][p] == 
         sum(arc in Arcs : arc.f == s) x[arc][t][p];
       }
     }
   }
 }

main {
  thisOplModel.generate();
  cplex.solve();
  thisOplModel.postProcess();
} 
