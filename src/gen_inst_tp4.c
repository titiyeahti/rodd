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
  int P, n;
  float w1, w2, L, g;

  P = 1;

  g = 1.26157;
  w1 = 1.;
  w2 = 5.;
  L = 3.;

  FILE* stream;
  char buffer[1000];

  int tmin = 60, tmax = 100;

  for(n=10; n<101; n+=5){
    for(i=0; i<NB_IT; i++){
      sprintf(buffer, "instances/tp4/inst_tp4_%d_%d.dat", n, i);
      stream = fopen(buffer, "w");
      
      if(!stream)
        return EXIT_FAILURE;

      gen_value(stream, (void*) &P, 1, "P");
      gen_value(stream, (void*) &n, 1, "n");
      gen_value(stream, (void*) &n, 1, "m");
      gen_value(stream, (void*) &w1, 0, "w1");
      gen_value(stream, (void*) &w2, 0, "w2");
      gen_value(stream, (void*) &L, 0, "L");
      gen_value(stream, (void*) &g, 0, "g");

      int dims[2] = {n, n};

      gen_matrix(stream, dims, 2, (void*) &tmax, (void*) &tmin, 1, "t");

      fclose(stream);
    }
  }

  return EXIT_SUCCESS;
}


