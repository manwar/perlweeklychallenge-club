//
// Task 1: Monotonic Array
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


// bool ismon = ismonotonic( list, nel );
//	Return true iff @list[0..nel-1] is monotonically increasing, ie.
//	for i <= j , list[i] <= list[j].  Else return false.
//
bool ismonotonic( int *list, int nel )
{
	for( int a=0; a<nel-1; a++ )
	{
		for( int b=a+1; b<nel; b++ )
		{
			if( list[a] > list[b] ) return false;
		}
	}
	return true;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "monotonic-array", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( nel < 2 )
	{
		fprintf( stderr, "monotonic-array: need a list of at least 2 elements\n" );
		exit(1);
	}

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	bool ismon = ismonotonic( list, nel );

	// reverse list
	for( int i=0, j=nel-1; i<j; i++, j-- )
	{
		int t = list[i];
		list[i] = list[j];
		list[j] = t;
	}

	ismon |= ismonotonic( list, nel );
	printf( "%d\n", ismon?1:0 );

	free( list );

	return 0;
}
