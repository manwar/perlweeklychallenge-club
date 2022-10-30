//
// Task 1: Divisible Pairs
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
	int argno = process_flag_n_m_args( "divisible-pairs", argc, argv,
		3, 100, "k list(int)" );
	if( argc < 3 )
	{
		fprintf( stderr,
			"Usage: divisible-pairs [--debug] k list(int)\n" );
		exit(1);
	}
	int k = atoi( argv[argno++] );
	if( k < 1 )
	{
		fprintf( stderr,
			"divisible-pairs: k (%d) must be +ve\n", k );
		exit(1);
	}
	int nel;
	int *ilist = parse_int_args( argc, argv, argno, &nel );

	if( debug )
	{
		//printf( "debug: argno=%d, k=%d, nel=%d\n", argno, k, nel );
		printf( "debug: k=%d, list=", k );
		print_int_array( 70, nel, ilist, ',', stdout );
		putchar( '\n' );
	}

	int found = 0;

	for( int i=0; i<nel-1; i++ )
	{
		for( int j=i+1; j<nel; j++ )
		{
			if( (ilist[i] + ilist[j] ) % k == 0 )
			{
				if( debug )
				{
					printf( "found pair %d, %d (elements "
						"%d, %d)\n", i, j,
						ilist[i], ilist[j] );
				}
				found++;
			}
		}
	}
	printf( "%d\n", found );

	free( ilist );

	return 0;
}
