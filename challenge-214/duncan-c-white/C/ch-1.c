// Task 1: Rank Score
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
#include "rank.h"


static int intcmp_desc( const void *a, const void *b )
{
	int *ap = (int *)a;
	int *bp = (int *)b;
	return *bp - *ap;
}


//
// bool in = isin( v, list, nel );
//	Return true iff v is in list[nel].
//
bool isin( int v, int *list, int nel )
{
	for( int i=0; i<nel; i++ )
	{
		if( list[i] == v ) return true;
	}
	return false;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "rank-score", argc, argv,
		1, 1000, "intlist" );
	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( debug )
	{
		printf( "debug: list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	int sorted[nel];
	memcpy( sorted, list, nel*sizeof(int) );

	// sort in DESCENDING sorted order
	qsort( sorted, nel, sizeof(int), &intcmp_desc );

	// allocate ranks, coping with joint ranks..
	int rank = 1;
	int result[ nel ];

	// foreach distinct value <val> in sorted order
	for( int i=0; i<nel; i++ )
	{
		if( i==0 || ! isin( sorted[i], sorted, i ) )	// distinct
		{
			int val = sorted[i];
			if( debug )
			{
				printf( "distinct value %d\n", val );
			}

			int n = 0;
			for( int j=0; j<nel; j++ )
			{
				if( list[j] == val )
				{
					result[j] = rank;
					n++;
				}
			}
			rank+=n;
		}
	}

	print_rank_array( 60, nel, result, ',', stdout );
	putchar( '\n' );

	free( list );
	return 0;
}
