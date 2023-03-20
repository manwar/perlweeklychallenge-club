//
// Task 2: Duplicate and Missing
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


// bool isin = in_list( target, arr, nel );
bool in_list( int target, int *arr, int nel )
{
	for( int i=0; i<nel; i++ )
	{
		if( arr[i] == target ) return true;
	}
	return false;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "h-index", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	// check that it's sorted
	int prev = list[0];
	for( int i=1; i<nel; i++ )
	{
		if( list[i] < prev )
		{
			fprintf( stderr, "dum: not sorted at element %d\n",
				list[i] );
			exit(1);
		}
		prev = list[i];
	}

	int base = list[0];
	int dup = -1;

	// find any duplicate, and die if there's only one duplicate
	for( int i=0; i<nel; i++ )
	{
		int expect = base+i;
		int el = list[i];
		if( el > expect )
		{
			fprintf( stderr, "dum: bad input element %d\n", el );
			exit(1);
		}
		if( in_list( el, list, i ) )
		{
			if( dup > -1 )
			{
				fprintf( stderr, "dum: multiple duplicates "
					 "found at element %d\n", el );
				exit(1);
			}
			dup = el;
		}
	}

	if( dup == -1 )
	{
		printf( "-1\n" );
		exit( 0 );
	}

	if( debug )
	{
		printf( "dup is %d\n", dup );
	}

	// missing is sole member of {B..B+N-1} - all el[i]
	int missing = -1;

	for( int i=0; i<nel; i++ )
	{
		int el = base+i;
		if( ! in_list( el, list, nel ) )
		{
			missing = el;
			if( debug )
			{
				printf( "found missing value %d\n", el );
			}
		}
	}

	if( missing == -1 )
	{
		fprintf( stderr, "No missing value found\n" );
		exit(1);
	}

	printf( "(%d, %d)\n", dup, missing );

	free( list );

	return 0;
}
