/* 
 * TASK 1 - Prime Partition
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-1.pl.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
//#include <stdint.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>
#include <ctype.h>

#include "args.h"
#include "primes.h"



#define MAXSTRINGLEN 800
typedef char string[MAXSTRINGLEN];


#define MAXPRIMES 512


int main( int argc, char **argv )
{
	int m, n;
	process_twonumargs( "prime-partition", argc, argv, &m, &n );

	// get all primes less than m
	int numprimes;
	int *primes = primes_upto( m, &numprimes );
	if( debug )
	{
		printf( "found %d primes, %d, %d, %d...%d\n",
			numprimes, primes[0], primes[1], primes[2],
			primes[numprimes-1] );
	}
	assert( numprimes < MAXPRIMES );

	string pps = "";	// single string "pp1 or pp2 ..."

	int two2n = 1<<numprimes;

	for( int i=1; i<two2n; i++ )
	{
		int chosen[MAXPRIMES];
		int nchosen = 0;
		int sum = 0;
		int mask = two2n>>1;
		for( int pos=0; pos<numprimes; pos++ )
		{
			if( (i&mask) )
			{
				chosen[nchosen++] = primes[pos];
				sum += primes[pos];
				#if 0
				if( debug )
				{
					printf(
					   "debug: i=%d, chosen %d, sum %d\n",
					   i, primes[pos], sum );
				}
				#endif
			}
			mask >>= 1;
		}
		#if 0
		if( debug )
		{
			printf( "debug: i=%d, nchosen=%d, sum=%d\n",
				i, nchosen, sum );
		}
		#endif

		if( sum == m && nchosen == n )
		{
			string buf = "";
			char *p = buf;
			for( int i=0; i<n; i++ )
			{
				sprintf( p, "%d, ", chosen[i] );
				p += strlen(p);
			}
			p[strlen(p)-2] = '\0';
			if( debug )
			{
				printf( "debug: i=%d: found a pp: %s\n", i, buf );
			}
			int len = strlen(pps);
			assert( len + strlen(buf) + 5 < MAXSTRINGLEN );
			strcat( pps, buf );
			strcat( pps, " or " );
		}
	}

	// remove trailing " or "..
	int len = strlen(pps);
	if( len>0 )
	{
		pps[len-4] = '\0';
	}
	printf( "%s\n", pps );

	return 0;
}
