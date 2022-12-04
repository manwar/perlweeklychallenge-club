//
// Task 1: Binary Flip
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


int main( int argc, char **argv )
{
	int n;
	process_onenumarg_default( "binary-flip", argc, argv, 100, &n );

	if( debug )
	{
		printf( "debug: n=%d\n", n );
	}

	int p = 1;
	while( p < n )
	{
		p *= 2;
	}

	n = (~ n) & (p-1);
	printf( "%d\n", n );

	return 0;
}
