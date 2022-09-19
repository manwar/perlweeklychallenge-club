// isprime module: contains an isprime(n) function

#include <stdio.h>
#include <stdbool.h>
#include <math.h>


//
// bool isprime = isprime( x );
//	Return true iff x is prime, false otherwise.
//
bool isprime( int x )
{
	int lim = (int)sqrt((double)x);
	for( int i=2; i<=lim; i++ )
	{
		if( x % i == 0 ) return 0;
	}
	return 1;
}
