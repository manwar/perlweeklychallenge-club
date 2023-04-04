
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>

#include "args.h"
#include "parseints.h"
#include "printarray.h"


#define MAX(a,b)	((a)>(b)?(a):(b))

int max = 0;

int intcompare( const void *a, const void *b )
{
	return *((int *)a) - *((int *)b);
}


//
// int pos = posinlist( v, nel, list );
//	Return the position of v if it's in list[nel], -1 otherwise
//
int posinlist( int v, int nel, int *list )
{
	for( int i=0; i<nel; i++ )
	{
		if( list[i] == v ) return i;
	}
	return -1;
}


//
// findall( sumsofar, nel, list );
//	Given a sumsofar, and a list[nel], find all "kill-and-win"
//	paths through the list, updating max with the maximum
//	of all total sums of each complete path.
//
void findall( int sumsofar, int nel, int *list )
{
	if( nel == 0 )
	{
		max = MAX( max, sumsofar );
		return;
	}

	// find all distinct values in list
	int *distinct = malloc( nel * sizeof(int) );
	assert( distinct != NULL );
	int ndistinct = 0;
	for( int i=0; i<nel; i++ )
	{
		if( posinlist( list[i], ndistinct, distinct ) == -1 )
		{
			distinct[ndistinct++] = list[i];
		}
	}
	// sort them
	qsort( distinct, ndistinct, sizeof(int), &intcompare );

	if( debug )
	{
		printf( "debug: distinct values: " );
		print_int_array( 60, ndistinct, distinct, ',', stdout );
		putchar( '\n' );
	}

	for( int i=0; i<ndistinct; i++ )
	{
		// ok, pick distinct[i] as our value to kill-and-win
		int v = distinct[i];

		// kaw rule: remove all v-1 and v+1 values and ONE v value

		// give ourselves two new arrays:

		// the one containing the elements we delete
		int *deleted = malloc( nel * sizeof(int) );
		assert( deleted != NULL );
		int ndeleted = 0;
		int delsum = 0;

		// and the one containing the elements we keep
		int *newl = malloc( nel * sizeof(int) );
		assert( newl != NULL );
		int newn = 0;

		int nvseen = 0;			// how many "v"s have we seen
		for( int j=0; j<nel; j++ )
		{
			int el = list[j];
			bool include = true;
			if( el == v-1 || el == v+1 )
			{
				include = false;
			} else if( el == v )
			{
				if( nvseen++ == 0 )
				{
					include = false;  // delete 1st v
				}
			}
			if( include )
			{
				newl[newn++] = el;
			} else
			{
				deleted[ndeleted++] = el;
				delsum += el;
			}
		}

		int newsum = sumsofar + delsum;
		if( debug )
		{
			printf( "debug: kaw: list=" );
			print_int_array( 60, nel, list, ',', stdout );
			printf( ", v=%d, deleted=", v );
			print_int_array( 60, ndeleted, deleted, ',', stdout );
			printf( ", newl=" );
			print_int_array( 60, newn, newl, ',', stdout );
			printf( ", newsum=%d\n", newsum );
		}
		findall( newsum, newn, newl );

		free( deleted );
		free( newl );
	}
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "kill-and-win", argc, argv,
		1, 1000, "intlist" );
	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	max = 0;
	findall( 0, nel, list );
	printf( "%d\n", max );

	free( list );

	return 0;
}
