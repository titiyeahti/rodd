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

#define Nmax 100
#define Pmax 20
#define POP 10
#define B 10

#define UNIF_01() (double)rand()/(double)RAND_MAX
#define UNIF_ALPHA() 0.5 + UNIF_01()/2.
#define RAND_INT(a, b) a + rand() % b


/* Ajuster la taille des float écrits */
int main(void){
  FILE* stream;
  int i, j, k, s, n, p, id;
  char buf[100];

  for(n=10; n<Nmax; n+=10){
    for(p=3; p<4; p+=2){
      for(id = 0; id<POP; id++){

        sprintf(buf, "instances/inst_%d_%d_%d.dat", n, p, id);
        stream = fopen(buf, "w");

        /* INTEGERS */
        fprintf(stream, "m=%d;\n", n);
        fprintf(stream, "n=%d;\n", n);
        fprintf(stream, "p=%d;\n", p);
        fprintf(stream, "q=%d;\n\n", p);
        

        /* ALPHA */
        fprintf(stream, "alpha=[");
        for(i=0; i<2*p-1; i++)
          fprintf(stream, "%f,", UNIF_ALPHA());

        fprintf(stream, "%f];\n\n", UNIF_ALPHA());

        /* PROBA */

        fprintf(stream, "proba=[");
        for(s=0; s<2*p; s++){
          fprintf(stream, "[");
          for(i=0; i<n; i++){
            fprintf(stream, "[");
            for(j=0; j<n; j++){
              fprintf(stream, "%f", UNIF_01());
              if(j != n-1)
                fprintf(stream, ",");
            }
            if(i == n-1)
              fprintf(stream, "]");
            else 
              fprintf(stream, "],\n");

          }
          if(s == 2*p - 1)
            fprintf(stream, "]");
          else 
            fprintf(stream, "],\n");
        }

        fprintf(stream, "];\n\n");

        /* C */
        fprintf(stream, "c=[");
        for(i=0; i<n; i++){
          fprintf(stream, "[");
          for(j=0; j<n; j++){
            fprintf(stream, "%d", RAND_INT(1,B));
            if(j!=n-1)
              fprintf(stream, ",");
          }
          if(j!=n-1)
            fprintf(stream, "],\n");
          else
            fprintf(stream, "]");
        }
        fprintf(stream, "];\n");
        fclose(stream);
      }
    }
  }

  return EXIT_SUCCESS;
}

