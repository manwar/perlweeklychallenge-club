//
// Task 2: Total Zero
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
//#include "parseints.h"
//#include "printarray.h"


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "total-zero", argc, argv,
		2, "x y" );
	int x = atoi( argv[argno++] );
	int y = atoi( argv[argno++] );

	if( x < 0 )
	{
		fprintf( stderr, "total-zero: x (%d) must be +ve\n", x );
		exit(1);
	}
	if( y < 0 )
	{
		fprintf( stderr, "total-zero: y (%d) must be +ve\n", y );
		exit(1);
	}

	int count = 0;
	if( debug )
	{
		printf( "debug: count=%d, x=%d, y=%d\n", count, x, y );
	}
	while( x>0 && y>0 )
	{
		if( x >= y )
		{
			x -= y;
		} else
		{
			y -= x;
		}
		count++;
		if( debug )
		{
			printf( "debug: count=%d, x=%d, y=%d\n", count, x, y );
		}
	}
	printf( "%d\n", count );

	return 0;
}
