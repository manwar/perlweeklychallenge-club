//
// Task 1: Zip List
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
#include "parseints.h"
#include "printarray.h"


// zip( n1, one, n2, two, result );
//	Take two arrays (one and two) and their sizes (n1 and n2),
//	and an empty array (result) big enough to store all n1+n2 items,
//	and zip them together as the task requires.
//	The single zipped array is left in result.
void zip( int n1, int *one, int n2, int *two, int *result )
{
	int nr=0;
	int i1, i2;
	for( i1=0, i2=0; i1<n1 && i2<n2; i1++,i2++ )
	{
		result[nr++] = one[i1];
		result[nr++] = two[i2];
	}
	// at this point, zero or one of the arrays are non-empty..
	// append any non-empty list by appending both:-)
	for( ; i1<n1; i1++ )
	{
		result[nr++] = one[i1];
	}
	for( ; i2<n2; i2++ )
	{
		result[nr++] = one[i2];
	}
	assert( nr==n1+n2 );
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "zip", argc, argv,
		2, "csvlist1 csvlist2" );

	if( debug )
	{
		printf( "debug: argno=%d, arg=%s\n", argno, argv[argno] );
	}

	int n1;
	int *one = parse_int_args( argno+1, argv, argno, &n1 );
	n1--;
	if( n1==0 )
	{
		fprintf( stderr, "zip: bad csvlist %s\n", argv[argno] );
		exit(1);
	}
	int n2;
	int *two = parse_int_args( argno+2, argv, argno+1, &n2 );
	n2--;
	if( n2==0 )
	{
		fprintf( stderr, "zip: bad csvlist %s\n", argv[argno+1] );
		exit(1);
	}

	int nr=n1+n2;
	int *result = malloc( sizeof(int) * nr );
	assert( result != NULL );

	zip( n1, one, n2, two, result );

	print_int_array( 78, nr, result, ',', stdout );
	putchar( '\n' );

	free( result );
	free( one );
	free( two );

	return 0;
}
