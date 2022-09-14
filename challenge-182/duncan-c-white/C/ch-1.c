//
// Task 1: Max Index
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


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "max-index", argc, argv,
		1, 100000, "array of ints" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	int maxpos = 0;
	int maxval = list[0];

	for( int pos=1; pos<nel; pos++ )
	{
		if( maxval >= list[pos] ) continue;
		maxval = list[pos];
		maxpos = pos;
	}

	printf( "%d\n", maxpos );

	free( list );

	return 0;
}
