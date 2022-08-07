/* 
 * Task 2: Reversible Numbers
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-2.pl.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
//#include <assert.h>

#include "args.h"


//
// bool isrev = is_reversible( x );
//	Return true iff x is reversible, otherwise return false.
//
bool is_reversible( int x )
{
	// let's do it entirely in the integer domain..
	int r = 0;	// will be reverse(x)
	int i = x;	// copy of x to destroy
	do {
		int dig = i % 10;
		r *= 10;
		r += dig;
		i /= 10;
	} while( i>0 );
	if( debug )
	{
		printf( "debug: x=%d, rev=%d\n", x, r );
	}
	//exit(1);

	int sum = x + r;
	do {
		int dig = sum % 10;
		if( dig%2 == 0 ) return 0;
		sum /= 10;
	} while( sum>0 );

	return 1;
}


int main( int argc, char **argv )
{
	int limit;
	process_onenumarg_default( "reversible-numbers-below-N",
				argc, argv, 100, &limit );
	limit--;

	//is_reversible( 123456 );

	for( int i=1; i<=limit; i++ )
	{
		if( is_reversible( i ) )
		{
			printf( "%d, ", i );
		}
	}
	putchar( '\n' );

	return 0;
}
