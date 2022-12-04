//
// Task 1: Binary Strings
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
// print_binary( x, nbits );
//	Print x out as an unsigned $nbits binary value.
//
void print_binary( int x, int nbits )
{
	int mask = 1<<(nbits-1);
	for( int i=0; i<nbits; i++ )
	{
		putchar( x&mask ? '1' : '0' );
		mask >>= 1;
	}
}


int main( int argc, char **argv )
{
	int n;
	process_onenumarg_default( "binary-strings", argc, argv, 100, &n );

	if( debug )
	{
		printf( "debug: n=%d\n", n );
	}

	int max = 1<<n;

	if( debug )
	{
		printf( "debug: max=%d\n", max );
	}

	for( int i=0; i<max; i++ )
	{
		print_binary( i, n );
		if( i<max )
		{
			putchar(',');
			putchar(' ');
		}
	}
	putchar( '\n' );

	return 0;
}
