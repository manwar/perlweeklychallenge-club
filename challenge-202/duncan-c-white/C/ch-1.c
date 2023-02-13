//
// Task 1: Consecutive Odds
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


// bool isodd = isodd( x );
//	Return 1 iff x is odd; else 0.
//
bool isodd( int x )
{
	return x % 2 == 1;
}


//
// bool hasodds = has3odds( list, nel );
//	Return true iff list has 3 consecutive odd numbers; else false.
//
bool has3odds( int *list, int nel )
{
	for( int i=0; i<nel-2; i++ )
	{
		if( ! isodd( list[i] ) ) continue;
		if( debug )
		{
			printf( "debug: found odd element %d at pos %d\n",
				list[i], i );
		}
		if( isodd( list[i+1] ) && isodd( list[i+2] ) )
		{
			if( debug )
			{
				printf( "debug: found 3 consec odd elements "
				        "%d, %d, %d starting at pos %d\n",
				        list[i], list[i+1], list[i+2], i );
			}
			return true;
		}
	}
	return false;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "3-consec-odds", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( nel < 3 )
	{
		fprintf( stderr, "3-consec-odds: need a list of > 2 elements\n" );
		exit(1);
	}

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	bool hasodds = has3odds( list, nel );
	printf( "%d\n", (int)hasodds );

	free( list );

	return 0;
}
