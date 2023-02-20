//
// Task 2: Reshape Matrix
// 
// C version.
// 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>

#include "args.h"


// int *el = parse_matrix( matstr, &nel );
//	Parse a matrix string in $matstr, and produce
//	the 1-D flattened array of elements in $matstr,
//	and set nel to the number of elements - or
//	return NULL for failure.
//
int * parse_matrix( char *matstr, int *nel )
{
	// count commas
	int n = 1;
	for( char *s=matstr; *s; s++ )
	{
		if( *s == ',' )
		{
			n++;
		}
	}
	if( debug )
	{
		printf( "debug: parse_matrix: n=%d\n", n );
	}
	*nel = n;

	char *digcomma = malloc( strlen(matstr) * sizeof(char) );
	assert( digcomma != NULL );

	// build a copy of the matstr containing only digits and commas..
	char *d = digcomma;
	*d = '\0';
	for( char *s=matstr; *s; s++ )
	{
		if( isdigit(*s) || *s == ',' )
		{
			*d++ = *s;
			*d = '\0';
		}
	}

	if( debug )
	{
		printf( "debug: parse_matrix: matstr=%s, digcomma=%s\n",
			matstr, digcomma );
	}

	int *result = malloc( n * sizeof(int) );
	assert( result != NULL );

	// walk digcomma, atoi()ing each digit sequence
	int i = 0;
	char *s = digcomma;
	char *p;
	while( (p=strchr(s,',')) != NULL )
	{
		*p = '\0';	// null-terminate string here (for now)
		result[i++] = atoi(s);
		*p = ',';	// change it back for neatness
		if( debug )
		{
			printf( "debug: s=%s, p=%s, result[%d]=%d\n",
				s, p, i-1, result[i-1] );
		}
		s = p+1;
	}
	result[i++] = atoi(s);

	free( digcomma );
	return result;
}


// print_resized_matrix( r2, c2, el, nel );
//	print out el[0..nel-1] as if it were a 2d matrix
//	is this cheating?  haven't formed a 2d matrix in memory
//	at all, just printing the right string out..
//	nah; not cheating:-)
//
void print_resized_matrix( int r2, int c2, int *el, int nel )
{
	int elno=0;
	for( int r=0; r<r2; r++ )
	{
		printf( "[ " );
		for( int c=0; c<c2; c++ )
		{
			printf( "%d%c ", el[elno++], c==c2-1?' ':',' );
		}
		printf( "]\n" );
	}
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "resize-matrix", argc, argv,
		3, "r c matrix" );

	int r2 = atoi(argv[argno++]);
	int c2 = atoi(argv[argno++]);
	char * mat = argv[argno++];

	if( r2 < 1 )
	{
		fprintf( stderr, "resize-matrix: r (%d) must be +ve\n", r2 );
		exit(1);
	}
	if( c2 < 1 )
	{
		fprintf( stderr, "resize-matrix: c (%d) must be +ve\n", c2 );
		exit(1);
	}
	int nel;
	int *el = parse_matrix( mat, &nel );
	if( el == NULL )
	{
		fprintf( stderr, "resize-matrix: bad matrix (%s)\n", mat );
		exit(1);
	}

	// ok, print out the elements as a matrix
	int n2 = r2 * c2;
	if( debug )
	{
		printf( "debug: nel=%d, r2=%d, c2=%d, n2=%d\n",
			nel, r2, c2, n2 );
	}
	if( nel == n2 )
	{
		print_resized_matrix( r2, c2, el, nel );
	} else
	{
		printf( "0\n" );
	}

	free( el );

	return 0;
}
