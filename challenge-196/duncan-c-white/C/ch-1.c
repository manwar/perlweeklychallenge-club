//
// Task 1: Pattern 132
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


//
// int * found = find_pat_132( arr, n );
//	Find and return a 3-element freshly malloc()d array found[] containing
//	the first subsequence of arr that matches the 132 rules above, or
//	return NULL if none.
//
int * find_pat_132( int *arr, int n )
{
	for( int i=0; i<n-2; i++ )
	{
		for( int j=i+1; j<n-1; j++ )
		{
			for( int k=j+1; k<n; k++ )
			{
				if( arr[i] < arr[k] && arr[k] < arr[j] )
				{
					int *list = malloc( 3 * sizeof(int) );
					assert( list != NULL );
					list[0] = arr[i];
					list[1] = arr[j];
					list[2] = arr[k];
					return list;
				}
			}
		}
	}
	return NULL;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "pattern-132", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( nel < 2 )
	{
		fprintf( stderr, "pattern-132: need a list of > 1 elements\n" );
		exit(1);
	}

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	if( nel < 1 )
	{
		fprintf( stderr, "special-numbers: nel %d must be > 0\n", nel );
		exit(1);
	}

	int *sol = find_pat_132( list, nel );
	printf( "(" );
	if( sol != NULL )
	{
		printf( "%d, %d, %d", sol[0], sol[1], sol[2] );
		free( sol );
	}
	printf( ")\n" );

	free( list );

	return 0;
}
