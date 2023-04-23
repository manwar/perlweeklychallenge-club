// Task 1: Fun Sort
//
// C translation

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>

#include "args.h"
#include "parseints.h"
#include "printarray.h"


static int intcmp( const void *a, const void *b )
{
	int *ap = (int *)a;
	int *bp = (int *)b;
	return *ap - *bp;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "fun-sort", argc, argv,
		1, 1000, "intlist" );
	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( debug )
	{
		printf( "debug: list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	int *even = malloc( nel * sizeof(int) );
	assert( even != NULL );

	int *odd = malloc( nel * sizeof(int) );
	assert( odd != NULL );

	int neven = 0;
	int nodd = 0;

	for( int i=0; i<nel; i++ )
	{
		if( list[i] % 2 == 0 )
		{
			even[neven++] = list[i];
		} else
		{
			odd[nodd++] = list[i];
		}
	}

	qsort( even, neven, sizeof(int), &intcmp );
	qsort( odd, nodd, sizeof(int), &intcmp );

	for( int i=0; i<neven; i++ )
	{
		list[i] = even[i];
	}

	for( int i=0; i<nodd; i++ )
	{
		list[neven+i] = odd[i];
	}

	print_int_array( 60, nel, list, ',', stdout );
	putchar( '\n' );

	free( even );
	free( odd );
	free( list );
	return 0;
}
