#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>


// int *primes = primes_upto(n,&numprimes);
//	Generate a dynamic array of integers containing
//	all primes up to $n.  The array is zero-terminated.
//	We also set numprimes to the number of primes found.
//	The caller should free(primes) when they've finished
//	using it.
//
int * primes_upto( int n, int *numprimep )
{
	bool *isprime = (bool *) malloc( (n+1) * sizeof(bool) );
	assert( isprime != NULL );

	int i;
	for( i=1; i<=n; i++ )
	{
		isprime[i] = 1;		// initially
	}

	int upper = (int)(sqrt((double)(n)));
	//printf( "debug: n=%d, upper=%d\n", n, upper );
	for( i=2; i<=upper; i++ )
	{
		if( isprime[i] )
		{
			//printf( "debug: crossing out multiples of %d\n", i );
			int j;
			for( j=i*i; j<=n; j+=i )
			{
				isprime[j] = 0;
			}
		}
	}

	// count how many primes there are
	int np = 0;
	for( i=2; i<=n; i++ )
	{
		if( isprime[i] )
		{
			np++;
		}
	}
	*numprimep = np;

	// dynamically allocate an array of np+1 ints, and fill it in
	int *primes = malloc( (np+1) * sizeof(int) );
	int p = 0;
	for( i=2; i<=n; i++ )
	{
		if( isprime[i] )
		{
			primes[p++] = i;
		}
	}
	primes[p] = 0;

	free( isprime );

	return primes;
}
