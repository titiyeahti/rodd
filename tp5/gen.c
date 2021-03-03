/*
 * =====================================================================================
 *
 *       Filename:  gen_ints.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  20/01/2021 16:27:29
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Thibaut Milhaud (tm), thibaut.milhaud@ensiie.fr
 *   Organization:  ensiie, univ-tln/Imath
 *
 * =====================================================================================
 */
#include <stdlib.h>
#include <stdio.h>

#define REP 100
#define S 12
#define BOT 50
#define WIDTH 20

#define UNIF_01() (double)rand()/(double)RAND_MAX
#define UNIF_D() BOT + UNIF_01()*WIDTH
#define RAND_INT(a, b) a + rand() % b


/* Ajuster la taille des float écrits */
int main(void){
  FILE* stream;
  int i, j, s;
  char buf[100];

  for(s=0; s<S; s++){
    for(i=0; i<REP; i++){

        sprintf(buf, "instances/inst_%d_%d.dat", s, i);
        stream = fopen(buf, "w");

        fprintf(stream, "S = %d;\n", s);

        fprintf(stream, "d = [");

        for(j=0; j<S; j++){
          fprintf(stream, "%.*f", 2, UNIF_D());
          if(j==S-1)
            fprintf(stream, "];");
          else
            fprintf(stream, ", ");
        }

        fclose(stream);
    }
  }

  return EXIT_SUCCESS;
}

