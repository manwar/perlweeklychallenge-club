/* 
 * Task 1 - Disarium Numbers
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-1.pl.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
//#include <stdint.h>
#include <string.h>
#include <assert.h>

#include "args.h"


//
// int p = intpower( x, y );
//	Compute x**y (x to-the-power y).
//
int intpower( int x, int y )
{
	int p = x;
	for( int i=1; i<y; i++ )
	{
		p *= x;
	}
	//printf( "%d ** %d = %d\n", x, y, p );
	return p;
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
	int sum = 0;
	for( int pos=0; pos < ndig; pos++ )
	{
		sum += intpower( dig[pos]-'0', (pos+1) );
	}
	if( debug )
	{
		printf( "debug: dis(%d): sum=%d\n", x, sum );
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
