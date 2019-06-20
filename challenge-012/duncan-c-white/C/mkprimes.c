#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <assert.h>
#include <math.h>


// creates primes.[ch]

int main( int argc, char **argv )
{
	int n = 5001;		// find all primes up to 5001 by default..

	if( argc == 1 )
	{
		n = 5001;
	} else if( argc == 2 )
	{
		n = atoi( argv[1] );
	} else
	{
		fprintf( stderr, "Usage: mkprimes [MAXVALUE]\n" );
		exit(1);
	}

	int *isprime = (int *) malloc( (n+1) * sizeof(int) );
	assert( isprime != NULL );

	int i;
	for( i=1; i<=n; i++ )
	{
		isprime[i] = 1;		// inititally
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
	int np=0;
	FILE *out = fopen( "primes.pl", "w" );
	assert( out != NULL );

	fprintf( out, "# array of all primes <= %d (nb: 1 is not a prime)\n\n", n );
	fprintf( out, "my @prime = (" );
	for( i=2; i<=n; i++ )
	{
		if( isprime[i] )	// finally
		{
			if( np % 10 == 0 )
			{
				fprintf( out, "\n\t" );
			}
			fprintf( out, "%d, ", i );
			np++;
		}
	}
	fprintf( out, "\n);\n\n" );
	fprintf( out, "my $NPRIMES = %d;\n", np );

	fclose( out );
}
