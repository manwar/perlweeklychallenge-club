/* 
 * TASK #1 - Prime Palindrome
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-1.pl.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>
#include <ctype.h>

#include "primes.h"



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
	if( left != 1 )
	{
		fprintf( stderr,
			"Usage: prime-palindrome [-d] firstN\n" );
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


/*
 * bool ispal = ispalindrome( x );
 *	Return 1 iff $x is palindromic in base 10, otherwise 0.
 */
bool ispalindrome( int x )
{
	char str[20];
	sprintf( str, "%d", x );
	int len = strlen(str);
	for( int i=0; i<len/2; i++ )
	{
		if( str[i] != str[len-1-i] )
		{
			return 0;
		}
	}
	return 1;
}


int main( int argc, char **argv )
{
	int firstn = process_singlearg( argc, argv );
	int *primes = primes_upto( firstn );

	//bool ispal = ispalindrome( firstn );
	//printf( "ispal(%d)? %d\n", firstn, (int)ispal );

	printf( "Palindromic primes up to %d\n", firstn );
	for( int i=0; primes[i] > 0; i++ )
	{
		if( ispalindrome( primes[i] ) )
		{
			printf( "%d\n", primes[i] );
		}
	}

	free( primes );
	return 0;
}
