//
// Task 1: Twice Largest
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


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "twice-largest", argc, argv,
		1, 1000, "csvlist(int)" );
	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( debug )
	{
		printf( "debug: nel=%d\n", nel );
		print_int_array( 70, nel, list, ',', stdout );
		putchar('\n');
	}

	int max = list[0];
	for( int i=1; i<nel; i++ )
	{
		if( list[i] > max ) max = list[i];
	}

	if( debug )
	{
		printf( "debug: max el = %d\n", max );
	}

	int n = 0;
	for( int i=0; i<nel; i++ )
	{
		if( list[i] != max && max < 2 * list[i] )
		{
			n++;
			if( debug )
			{
				printf( "debug: list is not cute because "
					"%d < 2 * %d\n", max, list[i] );
			}
			break;
		}
	}

	int result = (n == 0) ? 1 : -1;

	printf( "%d\n", result );

	free( list );

	return 0;
}
