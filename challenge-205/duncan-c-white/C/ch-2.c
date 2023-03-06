//
// Task 2: Maximum XOR
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
	int argno = process_flag_n_m_args( "max-xor", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	int max = -1;
	int maxa = -1;
	int maxb = -1;

	for( int i=0; i<nel-1; i++ )
	{
		for( int j=i+1; j<nel; j++ )
		{
			int a = list[i]+0;
			int b = list[j]+0;
			int xor = a^b;
			//say "debug: i=$i, j=$j, a=$a, b=$b, xor=$xor, max=$max" if $debug;
			if( xor > max )
			{
				max = xor;
				maxa = a;
				maxb = b;
			}
		}
	}

	printf( "%d\n", max );

	if( debug )
	{
		printf( "The maximum result of %d xor %d = %d\n",
			maxa, maxb, max );
	}

	free( list );

	return 0;
}
