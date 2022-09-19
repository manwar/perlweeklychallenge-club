/* 
 * TASK 1 - Odd Abundant Numbers
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-1.pl;
 * I took the liberty of merging finding factors and summing them.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
//#include <stdint.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>
#include <ctype.h>


bool debug=false;


// int n = process_singlearg( name, argc, argv, def );
//	Process the -d flag, and check that there is a single
//	remaining argument (or return $def if there are no args),
//	return that argument's numeric value.
int process_singlearg( char *name, int argc, char **argv, int def )
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
		return def;		// default
	}
	if( left != 1 )
	{
		fprintf( stderr,
			"Usage: %s [-d] firstN (default %d)\n", name, def );
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


//
// int sum_f = sum_factors_less_than_n( n );
//	Find all the factors of n
//	including 1 but less than n.
//	Sum them all and return the sum.
//
int sum_factors_less_than_n( int n )
{
	int sumf = 0;
	for( int i=1; i<n; i++ )
	{
		 if( n%i == 0 ) sumf += i;
	}
	return sumf;
}


int main( int argc, char **argv )
{
	int n = process_singlearg( "odd-abundant-nos", argc, argv, 20 );

	int *oa;		// the first n Odd Abundant numbers
	oa = malloc( n * sizeof(int) );
	int noa = 0;

	for( int i = 3; noa<n; i+=2 )
	{
		int sum = sum_factors_less_than_n( i );
		if( debug )
		{
			printf( "i=%d, sum=%d\n", i, sum );
		}
		if( sum > i )
		{
			if( debug )
			{
				printf( "found odd abdundant no %d\n", i );
			}
			oa[noa++] = i;
		}
	}

	for( int i=0; i<noa; i++ )
	{
		printf( "%d\n", oa[i] );
	}

	free( oa );
	return 0;
}
