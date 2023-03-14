//
// Task 2: H-Index
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


int intcompare( const void *ap, const void *bp )
{
	int a = *((int *)ap);
	int b = *((int *)bp);
	return b-a;
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

	qsort( list, nel, sizeof(int), &intcompare );

	if( debug )
	{
		printf( "debug: sorted list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	int h = -1;

	for( int pos=0; pos<nel; pos++ )
	{
		if( list[pos] >= pos+1 ) h = pos+1;
	}

	printf( "%d\n", h );

	free( list );

	return 0;
}
