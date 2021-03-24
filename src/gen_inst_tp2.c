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
  int n;
  int B;
  int Amin, Amax;
  int cmin=2, cmax=11;
  float lambda = 20.;

  FILE* stream;
  char buffer[1000];

  for(n=10; n<41; n+=2){
    Amin = (4*n*n)/10;
    Amax = (5*n*n)/10;
    int dims[2] = {n, n};
    for(i=0; i<NB_IT; i++){
      sprintf(buffer, "instances/tp2/inst_tp2_%d_%d.dat", n, i);
      stream = fopen(buffer, "w");
      if(!stream)
        return EXIT_FAILURE;

      gen_value(stream, (void*) &n, 1, "m");
      gen_value(stream, (void*) &n, 1, "n");

      /* B is around 9/10 Amin * mean(c_ij) */
      B = Amin*48;
      gen_value(stream, (void*) &Amin, 1, "Amin");
      gen_value(stream, (void*) &Amax, 1, "Amax");
      gen_value(stream, (void*) &B, 1, "B");
      gen_value(stream, (void*) &lambda, 0, "lambda");

      gen_matrix(stream, dims, 2, (void*) &cmax, (void*) &cmin, 1, "c");

      fclose(stream);
    }
  }

  return EXIT_SUCCESS;
}


