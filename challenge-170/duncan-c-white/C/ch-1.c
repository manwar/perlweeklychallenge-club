/* 
 * TASK 1 - Primorial Numbers
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

#include "primes.h"


#define BIG double

bool debug=false;


// int n = process_singlearg( argc, argv );
//	Process the -d flag, and check that there is a single
//	remaining argument, return it's numeric value.
int process_singlearg( int argc, char **argv )
{
	int arg=1;
	if( argc>1 && strcmp( argv[arg], "-d" ) == 0 )
	{
		debug = true;
		arg++;
	}

	int left = argc-arg;
	if( left == 0 )
	{
		return 10;		// default
	}
	if( left != 1 )
	{
		fprintf( stderr,
			"Usage: primorial [-d] firstN (default 10)\n" );
		exit(1);
	}

	// element is in argv[arg]

	if( debug )
	{
		printf( "debug: remaining argument is in arg=%d, firstn=%s\n",
			arg, argv[arg] );
	}

	return atoi( argv[arg] );
}


int main( int argc, char **argv )
{
	int n = process_singlearg( argc, argv );

	// get first n or more primes
	int lim = n;
	int numprimes;
	int *primes = primes_upto( lim, &numprimes );
	while( numprimes < n )
	{
		free( primes );
		lim *= 2;
		primes = primes_upto( lim, &numprimes );
	}
	if( debug )
	{
	printf( "found %d primes, %d, %d, %d...%d\n",
		numprimes, primes[0], primes[1], primes[2],
		primes[numprimes-1] );
	}

	// now calculate the primorials

	BIG p = 1;			// current primorial
	BIG *primorials = malloc( numprimes * sizeof(BIG) );
	assert( primorials != NULL );
	primorials[0] = p;
	for( int i = 1; i < n; i++ )
	{
		int nextprime = primes[i-1];
		p *= nextprime;
		primorials[i] = p;
	}

	for( int i = 0; i < n; i++ )
	{
		printf( "%.0lf, ", primorials[i] );
	}
	putchar('\n');

	free( primorials );
	free( primes );
	return 0;
}
