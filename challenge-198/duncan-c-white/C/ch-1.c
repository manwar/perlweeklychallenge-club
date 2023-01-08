//
// Task 1: Max Gap
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


static int int_compare( const void *a, const void *b )
{
	return (*(int *)a) - (*(int *)b);
}


typedef char shortstr[20];


//
// int maxgap;
// char *pairsstr;
// int npairs = find_max_gap( list, nel, &maxgap, &pairsstr );
//	Find the maximum gap (maxgap) between any 2 elements in the
//	sorted list (list, nel elements), and pairsstr (a dynamically
//	allocted CSV of "el-el" strings) of elements with that maxgap.  Return
//	the number of such pairs found
//
int find_max_gap( int *list, int nel, int *maxgap, char **pairsstr )
{
	*maxgap = 0;
	int npairs = 0;
	char *p = *pairsstr = malloc( nel * 10 * sizeof(char) );
	assert( p != NULL );
	for( int i=0; i<nel; i++ )
	{
		int gap = list[i+1] - list[i];
		if( debug )
		{
			printf( "debug %d: %d..%d, gap=%d\n",
				i, list[i], list[i+1], gap );
		}
		if( gap > *maxgap )
		{
			*maxgap = gap;
			sprintf( p, "%d-%d", list[i], list[i+1] );
			npairs = 1;
		} else if( gap == *maxgap )
		{
			char *end = p + strlen(p);
			sprintf( end, ",%d-%d", list[i], list[i+1] );
			npairs++;
		}
	}
	return npairs;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "max-gap", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( nel < 1 )
	{
		fprintf( stderr, "max-gap: need a list of > 0 elements\n" );
		exit(1);
	}


	qsort( list, nel, sizeof(int), &int_compare );

	if( debug )
	{
		printf( "debug: initial sorted list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	int maxgap;
	char *pairsstr;
	int npairs = find_max_gap( list, nel, &maxgap, &pairsstr );

	if( debug )
	{
		printf( "debug: maxgap=%d, npairs=%d, pairstr=%s\n",
			maxgap, npairs, pairsstr );
	} else
	{
		printf( "%d\n", npairs );
	}

	free( pairsstr );
	free( list );

	return 0;
}
