//
// Task 2: Cute List
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
#include "nextintperm.h"


//
// bool iscute = is_cute( arr, n );
//	Return true iff arr[0..n-1] is cute, as in the top spec.
//	Return false otherwise.
//
bool is_cute( int *arr, int n )
{
	for( int i0=0; i0<n; i0++ )
	{
		int index = i0+1;	// index base at 1
		int val = arr[i0];
		// NOT cute if both are NOT evenly disible by tother
		if( ( val % index != 0 ) && ( index % val != 0 ) )
		{
			return false;
		}
	}
	return true;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "cute-list", argc, argv,
		1, "N (1..15)" );

	int n = atoi( argv[argno++] );
	if( n < 1 || n > 15 )
	{
		fprintf( stderr, "cute-list: N (%d) must be in range 1..15)\n", n );
		exit(1);
	}

	if( debug )
	{
		printf( "debug: n=%d\n", n );
	}

	int list[16];
	for( int i=0; i<n; i++ )
	{
		list[i] = i+1;
	}
	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, n, list, ',', stdout );
		putchar( '\n' );
	}

	int ncute = 0;
	for( int i=1; ; i++ )
	{
		if( is_cute( list, n ) )
		{
			if( debug )
			{
				printf( "cute perm: " );
				print_int_array( 60, n, list, ',', stdout );
				putchar( '\n' );
			}
			ncute++;
		}
		bool exhausted = next_perm( list, n );
		if( exhausted ) break;
	}

	printf( "%d\n", ncute );

	return 0;
}
