//
// Task 2: Prime Count
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
#include "primes.h"


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "prime-count", argc, argv, 1, "" );
	char *arg = argv[argno];
	int n = atoi(arg);

	if( debug )
	{
		printf( "debug: arg=%s, n=%d\n", arg, n );
	}

	if( n < 1 )
	{
		fprintf( stderr, "prime-count: n %d must be > 0\n", n );
		exit(1);
	}

	int numprimes;
	int *primes = primes_upto(n-1,&numprimes);

	if( debug )
	{
		printf( "debug: there are %d primes < %d: \n", numprimes, n );
		print_int_array( 60, numprimes, primes, ',', stdout );
		putchar( '\n' );
	} else
	{
		printf( "%d\n", numprimes );
	}

	return 0;
}
