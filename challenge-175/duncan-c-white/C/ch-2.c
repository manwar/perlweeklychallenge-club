/* 
 * Task 2 - Perfect Totient Numbers
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-2.pl.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
//#include <assert.h>

#include "args.h"


//
// int result = gcd( a, b );
//       Compute and return the GCD (Greatest Common Denominator) of a and b.
//
int gcd( int a, int b )
{
        while( b != 0 )
        {
		int t = a % b;
		a = b;
		b = t;
        }
        return a;
}


//
// int ntot = totient( n );
//	This function counts the positive integers up to $n that are
//	relatively prime to $n.  In other words, it is the number of
//	values in the range 1 <= k <= n for which gcd(n, k) == 1.
//
int totient( int n )
{
	int result = 0;
	for( int k=1; k<=n; k++ )
	{
		if( gcd(n,k)==1 ) result++;
	}
	return result;
}


//
// bool isptn = is_perfect_totient_number( n );
//	A perfect totient number is an integer that is equal to the sum
//	of its iterated totients. That is, we apply the totient function
//	to a number n, apply it again to the resulting totient, and so on,
//	until the number 1 is reached, and add together the resulting
//	sequence of numbers; iff the sum equals n, then n is a perfect totient
//	number.
//
bool is_perfect_totient_number( int n )
{
	int sum = 0;
	int x = n;
	do {
		x = totient(x);
		sum += x;
		if( debug )
		{
			printf( "debug: x=%d, sum=%d\n", x, sum );
		}
	} while( x != 1 );
	return sum==n?1:0;
}


int main( int argc, char **argv )
{
	int n;
	process_onenumarg_default( "first-n-perfect-totient-numbers",
				argc, argv, 20, &n );

	int nfound = 0;
	for( int i=2; nfound<n; i++ )
	{
		if( is_perfect_totient_number( i ) )
		{
			printf( "%d, ", i );
			nfound++;
		}
	}
	putchar( '\n' );

	return 0;
}
