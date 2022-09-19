//
// Task 2: Palindromic Prime Cyclops
// 
// C version.
// 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#include "args.h"
#include "isprime.h"
#include "prarray.h"


// int r = reverse(n);
//	reverse the digits of n,
//	eg. reverse(12345) = 54321
int reverse( int n )
{
	int r=0;
	while( n > 0 )
	{
		r *= 10;
		r += n%10;
		n /= 10;
	}
	return r;
}


// bool hz = haszero(n);
//	return true iff n has any zero digits in it.
//	eg. haszero(12045) = true.
bool haszero( int n )
{
	while( n > 0 )
	{
		if( n%10 == 0 ) return true;
		n /= 10;
	}
	return false;
}


int main( int argc, char **argv )
{
	int n;
	process_onenumarg_default( "first-N-palindomic-prime-cyclops-numbers",
		argc, argv, 20, &n );

	// printf( "reverse(12345) = %d\n", reverse(12345) );
	//return 0;

	//printf( "debug: ip(1300031) = %d\n", isprime(1300031) );
	//return 0;

	int results[n];
	int found = 0;
	for( int x=1; found < n; x++ )
	{
		// must exclude x if it has a zero in it..
		if( haszero(x) )
		{
			continue;
		}
		char numstr[100];
		sprintf( numstr, "%d0%d", x, reverse(x) );
		int num = atoi(numstr);
		if( debug )
		{
			printf( "debug: x=%d, numstr=%s, num=%d\n", x, numstr, num );
		}
		if( isprime(num) )
		{
			results[found++] = num;
			if( debug )
			{
				printf( "debug: found prime %d\n", num );
			}
		}
	}

	print_int_array( 65, found, results, stdout );

	return 0;
}
