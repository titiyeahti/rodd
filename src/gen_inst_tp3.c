/*
 * =====================================================================================
 *
 *       Filename:  gen_inst_tp2.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  19/03/2021 19:14:42
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Thibaut Milhaud (tm), thibaut.milhaud@ensiie.fr
 *   Organization:  ensiie, univ-tln/Imath
 *
 * =====================================================================================
 */
#include "gen_matrix.h"

#define NB_IT 10

int main(){
  int i;
  int N, Nm;
  int C = 1, G, A, T;
  float init = 0.001;

  FILE* stream;
  char buffer[1000];

  for(Nm=4; Nm<15; Nm++){
    N = Nm<<1;

    for(G=5; G<9; G++){
      for(A=2; A<5; A++){

        int dims[4] = {N, C, G, 2};
        int minA = 1;
        int maxA = A+1;

        for(T=50; T<551; T+=100){
          sprintf(buffer, "instances/tp3/inst_tp3_%d_%d_%d_%d.dat", 
              N, G, A, T);
          stream = fopen(buffer, "w");

          gen_value(stream, (void*) &N, 1, "N");
          gen_value(stream, (void*) &Nm, 1, "Nm");
          gen_value(stream, (void*) &Nm, 1, "Nf");
          gen_value(stream, (void*) &C, 1, "C");
          gen_value(stream, (void*) &G, 1, "G");
          gen_value(stream, (void*) &A, 1, "A");
          gen_value(stream, (void*) &T, 1, "T");
          fprintf(stream, "\n%s = %f;\n", "init", init);

          gen_matrix(stream, dims, 4, (void*) &maxA, 
              (void*) &minA, 1, "individu");

          fclose(stream);
        }
      }
    }
  }

  return EXIT_SUCCESS;
}


