//
// Task 1: Third Highest
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


int intcomparedesc( const void *ap, const void *bp )
{
	int a = *((int *)ap);
	int b = *((int *)bp);
	return b-a;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "third-highest", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	qsort( list, nel, sizeof(int), &intcomparedesc );

	if( debug )
	{
		printf( "debug: sorted list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	// remove duplicates
	for( int i=0; i<nel-1; i++ )
	{
		if( list[i+1] == list[i] )
		{
			// shift i+2..end back one
			for( int j=i+2; j<nel; j++ )
			{
				list[j-1] = list[j];
			}
			nel--;
		}
	}

	if( debug )
	{
		printf( "debug: no dups list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	int third = ( nel > 2 ) ? list[2] : list[0];
	printf( "%d\n", third );

	free( list );

	return 0;
}
