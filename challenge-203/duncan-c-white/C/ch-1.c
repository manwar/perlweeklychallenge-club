//
// Task 1: Special Quadruplets
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


// int n = count_special_quads( list[], nel );
//	Find all special quads in list[0..nel-1], and count them.
//	In debug mode, list all the special quads we find.
int count_special_quads( int *list, int nel )
{
	int result = 0;
	for( int a = 0; a < nel-3; a++ )
	{
	   for( int b = a+1; b < nel-2; b++ )
	   {
	      for( int c = b+1; c < nel-1; c++ )
	      {
	      	 int sum = list[a] + list[b] + list[c];
	         for( int d = c+1; d < nel; d++ )
	         {
		    if( list[d] == sum )
		    {
		       if( debug )
		       {
		    	   printf( "debug: found sq %d-%d-%d-%d: %d+%d+%d==%d\n",
			     a, b, c, d, list[a], list[b], list[c], list[d] );
		       }
		       result++;
		    }
	         }
	      }
	   }
	}
	return result;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "3-consec-odds", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( nel < 4 )
	{
		fprintf( stderr, "special-quads: need a list of > 3 elements\n" );
		exit(1);
	}

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	int n = count_special_quads( list, nel );
	printf( "%d\n", n );

	free( list );

	return 0;
}
