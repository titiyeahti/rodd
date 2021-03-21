/*
 * =====================================================================================
 *
 *       Filename:  gen_matrix.h
 *
 *    Description:  A lib to generate and write random matrices of arbitrary dimensions
 *        into files.
 *
 *        Version:  1.0
 *        Created:  19/03/2021 15:39:36
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Thibaut Milhaud (tm), thibaut.milhaud@ensiie.fr
 *   Organization:  ensiie, univ-tln/Imath
 *
 * =====================================================================================
 */



#ifndef  gen_matrix_INC
#define  gen_matrix_INC

#include <stdlib.h>
#include <stdio.h>

#define UNIF_01() (float) ((double)rand()/(double)RAND_MAX)
#define RAND_INT(a, b) (a) + (rand() % ((b)-(a)))
#define RAND_FLOAT(a, b) (a) + (UNIF_01() * ((b)-(a)))

/* This function writes a matrix of dimension prod(i=0; i<dim) dim[i] 
 * to stream.
 * The elements of the matrix are randomly chosen between 
 * lower and *upper which must be of the correct type :
 *  * If is_int then int
 *  * otw float*/
int gen_matrix(FILE* stream, int* dims, int dim, 
    void* upper, void* lower, int is_int, char* name);

int gen_value(FILE* stream, void* value, int is_int, char* name);

#endif   /* ----- #ifndef gen_matrix_INC  ----- */
