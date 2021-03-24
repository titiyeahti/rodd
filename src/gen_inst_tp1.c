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

#define NB_IT 9

int main(){
  int i;
  int n, p;
  int cmin=2, cmax=11;
  float pmin=0.0, pmax=0.6;
  float alphamin=0.4, alphamax=0.6;

  FILE* stream;
  char buffer[1000];

  for(n=10; n<42; n+=2){
    for(p=2; p<5; p++){
      for(i=0; i<NB_IT; i++){
        sprintf(buffer, "instances/tp1/inst_tp1_%d_%d_%d.dat", n, p, i);
        stream = fopen(buffer, "w");
        if(!stream)
          return EXIT_FAILURE;

        gen_value(stream, (void*) &n, 1, "m");
        gen_value(stream, (void*) &n, 1, "n");
        gen_value(stream, (void*) &p, 1, "p");
        gen_value(stream, (void*) &p, 1, "q");

        int dimp[3] = {p<<1, n, n};
        gen_matrix(stream, dimp, 3, (void*) &pmax, (void*) &pmin, 0, "proba");
       
        int dima = p<<1;
        gen_matrix(stream, &dima, 1, (void*) &alphamax, 
            (void*) &alphamin, 0, "alpha");

        int dimc[2] = {n, n};
        gen_matrix(stream, dimc, 2, (void*) &cmax, (void*) &cmin, 1, "c");

        fclose(stream);
      }
    }
  }

  return EXIT_SUCCESS;
}


