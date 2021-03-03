/*
 * =====================================================================================
 *
 *       Filename:  boom.c
 *
 *    Description:  
 *
 *        Version:  1.0
 *        Created:  03/03/2021 18:12:14
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

int main(int argc, char** argv){

  FILE* stream = fopen("plot.dat", "a");
  int i;
  char buf[1000];
  char* flag;
  int s;
  float cost, eco;

  for(i=1; i<argc; i++){
    FILE* trash = fopen(argv[i], "r");
    if (!trash)
      return EXIT_FAILURE;

    printf("%s\n", argv[1]);
    while(1) {
      flag = fgets(buf, 800, trash);

      if(sscanf(buf, "##%d %f %f\n", &s, &cost, &eco)){
        printf("found\n");
        break;
      }
        
      if(!flag){
        printf("end\n");
        break;
      }
    }
    fclose(trash);
    fprintf(stream, "%d %f %f\n", s, cost, eco); 
  }

  fclose(stream);
  return EXIT_SUCCESS;
}




