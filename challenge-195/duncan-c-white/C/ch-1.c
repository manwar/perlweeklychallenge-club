//
// Task 1: Special Integers
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


//
// bool isspecial = special( x );
//	Return 1 iff x is special; 0 otherwise.
//
bool special( int x )
{
	int freq[10];

	for( int i=0; i<10; i++ ) freq[i]=0;

	// foreach digit in x
	for( ; x>0; x/=10 )
	{
		int digit = x%10;
		if( freq[digit] > 0 ) return false;
		freq[digit]++;
	}
	return true;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "special-numbers", argc, argv, 1, "" );
	char *arg = argv[argno];
	int n = atoi(arg);

	if( debug )
	{
		printf( "debug: arg=%s, n=%d\n", arg, n );
	}

	if( n < 1 )
	{
		fprintf( stderr, "special-numbers: n %d must be > 0\n", n );
		exit(1);
	}

	int nspec = 0;
	for( int i=1; i<=n; i++ )
	{
		if( special(i) )
		{
			nspec++;
		} else if( debug )
		{
			printf( "debug: %d is not special\n", i );
		}
	}
	printf( "%d\n", nspec );

	return 0;
}
