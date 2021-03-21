/*
 * =====================================================================================
 *
 *       Filename:  gen_matrix.c
 *
 *    Description:  A lib to generate and write random matrices of arbitrary dimensions
 *        into files.
 *
 *        Version:  1.0
 *        Created:  19/03/2021 15:38:33
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Thibaut Milhaud (tm), thibaut.milhaud@ensiie.fr
 *   Organization:  ensiie, univ-tln/Imath
 *
 * =====================================================================================
 */

#include "gen_matrix.h"

int print_rand_int(FILE* stream, int upper, int lower){
  if(!stream)
    return EXIT_FAILURE;

  fprintf(stream, "%d", RAND_INT(lower, upper));

  return EXIT_SUCCESS;
}

int print_rand_float(FILE* stream, float upper, float lower){
  if(!stream)
    return EXIT_FAILURE;

  fprintf(stream, "%0.2f", RAND_FLOAT(lower, upper));

  return EXIT_SUCCESS;
}


int gen_matrix(FILE* stream, int* dims, int dim, 
    void* upper, void* lower, int is_int, char* name){

  if(!stream)
    return EXIT_FAILURE;

  int nb_elt = 1;
  int q, r;
  int i, j;
  int newline;
  for(i=0; i<dim; i++){
    nb_elt *= dims[i];
  }

  fprintf(stream, "\n%s = \n", name);
  
  i = 0;
  while(i<nb_elt) {
    /* open brackets */
    q = i;
    for(j=0; j<dim; j++){
      r = q % dims[dim-j-1];
      if(!r)
        fprintf(stream, "[");
      else 
        break;
      
      q /= dims[dim-j-1];
    }

    if(is_int)
      print_rand_int(stream, *((int*) upper), *((int*) lower));
    else 
      print_rand_float(stream, *((float*) upper), *((float*) lower));

    i++;
   
    /* closing brackets and coma */
    q = i;
    newline = 0;
    for(j=0; j<dim; j++){
      r = q % dims[dim-j-1];
      if(!r){
        fprintf(stream, "]");
        newline = 1;
      }
      else{
        fprintf(stream, ",");
        if(newline)
          fprintf(stream, "\n");

        break;
      }
      q /= dims[dim-j-1];
    }
  }
  fprintf(stream, ";\n");
  return EXIT_SUCCESS;
}

int gen_value(FILE* stream, void* value, int is_int, char* name){
  if(!stream)
    return EXIT_FAILURE;

  if(is_int){
    int* iv = value;
    fprintf(stream, "\n%s = %d;\n", name, *iv);
  }
  else{
    float* fv = value;
    fprintf(stream, "\n%s = %0.2f;\n", name, *fv);
  }

  return EXIT_SUCCESS;
}
