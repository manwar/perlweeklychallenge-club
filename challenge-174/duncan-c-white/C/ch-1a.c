/* 
 * Task 1 - Disarium Numbers
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-1.pl.
 * Optimization: pre-compute all the powers of digits
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
//#include <stdint.h>
#include <string.h>
#include <assert.h>

#include "args.h"


unsigned long dpow[10][20];	// precomputed powers of digit ** n


//
// initialise_pow( );
//	Initialize the dpow[] array
void initialise_pow( void )
{
	for( int d = 0; d<10; d++ )
	{
		unsigned long dp = 1;
		for( int p = 0; p<20; p++ )
		{
			dpow[d][p] = dp;
			dp *= d;
			//printf( "dpow[%d][%d] = %lu\n", d, p, dpow[d][p] );
		}
	}
}


//
// unsigned long p = intpower( x, y );
//	Compute x**y (x to-the-power y).
//
unsigned long intpower( int x, int y )
{
	#if CALC
	int p = x;
	for( int i=1; i<y; i++ )
	{
		p *= x;
	}
	//printf( "%d ** %d = %d\n", x, y, p );
	return p;
	#else
	return dpow[x][y];
	#endif
}


//
// bool isdis = disarium( x );
//	Return 1 iff $x is a disarium number; 0 otherwise.
//
bool disarium( int x )
{
	char dig[100];
	sprintf( dig, "%d", x );
	int ndig = strlen(dig);
	unsigned long sum = 0;
	for( int pos=0; pos < ndig; pos++ )
	{
		sum += intpower( dig[pos]-'0', (pos+1) );
	}
	if( debug )
	{
		printf( "debug: dis(%d): sum=%lu\n", x, sum );
	}
	return sum == x ? 1 : 0;
}


int main( int argc, char **argv )
{
	int n;
	process_onenumarg_default( "disarium-numbers", argc, argv, 19, &n );

	//bool is = disarium(518);
	//printf( "debug: dis(518) = %d\n", is );
	//exit(0);

	initialise_pow( );

	char foundbuf[1024] = "";
	int nfound = 0;
	for( int i = 0; nfound < n; i++ )
	{
		// check if $i is a disarium number, if so add it to found
		if( disarium(i) )
		{
			if( debug )
			{
				printf( "debug: found dis %d\n", i );
			}
			nfound++;
			char ibuf[20];
			sprintf( ibuf, "%d", i );
			strcat( foundbuf, ibuf );
			strcat( foundbuf, "," );
		}
	}
	int len = strlen(foundbuf);
	foundbuf[len-1] = '\0';			// remove trailing ','

	printf( "%s\n", foundbuf );

	return 0;
}
