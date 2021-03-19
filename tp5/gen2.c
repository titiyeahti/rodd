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
  char dt[1000];
  

  for(i=0; i<REP; i++){
    sprintf(dt, "d = [");
    for(j=0; j<S; j++){
      sprintf(dt+j*6+5, "%.*f", 2, UNIF_D());

      if(j==S-1)
        sprintf(dt+9+j*6, "];");
      else
        sprintf(dt+9+j*6, ", ");
    }
    printf("%s", dt);
    for(s=0; s<S; s++){
      sprintf(buf, "instancesbis/inst_%d_%d.dat", s, i);
      stream = fopen(buf, "w");

      fprintf(stream, "S = %d;\n", s);
      fprintf(stream, "%s\n", dt);

      fclose(stream);
    }
  }

  return EXIT_SUCCESS;
}

