/* 
 * TASK #2 - Happy Numbers
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-2.pl.
 * The only tricky issue is how to represent the set of int.
 * Here I've gone for the obvious bitmap approach, but initializing
 * the seen bitmap in ishappy() takes a long time, making this hopelessly
 * slow over all.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>
#include <ctype.h>



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

	//if( debug )
	//{
	//	printf( "debug: remaining argument is in arg=%d, firstn=%s\n",
	//		arg, argv[arg] );
	//}

	return atoi( argv[arg] );
}


static int seen[UINT32_MAX/32];	// bitmap set


// bool ishap = ishappy( x );
//	Return 1 iff $x is a happy number (in base 10), otherwise return 0.
bool ishappy( int x )
{
	for( int i=0; i<UINT32_MAX/32; i++ )
	{
		seen[i] = 0;
	}
	while( x > 1 )
	{
		int si = x/32;
		int sm = x%32;
		if( (seen[si] & (1<<sm)) )
		{
			return 0;
		}
		seen[si] |= (1<<sm);
		//if( debug ) { printf( "debug: x=%d\n", x ); }

		//$x = sum0( map { $_ * $_ } split(//,$x) );
		int sum=0;
		while( x>0 )
		{
			int digit = x%10;
			x /= 10;
			sum += digit*digit;
		}
		x = sum;
	}
	return 1;
}


int main( int argc, char **argv )
{
	int firstn = process_singlearg( argc, argv );

	//printf( "ishappy(%d)? %d\n", firstn, (int)ishappy(firstn) );

	int nfound = 0;
	for( int n=1; nfound<firstn; n++ )
	{
		bool ishap = ishappy(n);
		if( debug )
		{
			char *str = ishap?"":"un";
			printf( "%d is %shappy\n", n, str );
		}
		if( ishap )
		{
			nfound++;
			if( nfound==firstn )
			{
				printf( "%d is happy number #%d\n", n, firstn );
			}
		}
	}
	return 0;
}
