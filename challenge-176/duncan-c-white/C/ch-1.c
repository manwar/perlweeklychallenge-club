/* 
 * Task 1: Permuted Multiples
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-1.pl.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
//#include <assert.h>

#include "args.h"


static int comparator( const void *p1, const void *p2 )
{
	// The actual arguments to this function are "pointers to
	// an individual char", so hence the typecasts.

	return *((char *) p1) - *((char *) p2);
}


// int x;
// char sigstr[20];
// mk_signature( x, sigstr );
//	Make the permutation signature of x in sigstr[].
//	That is, sort the digits of the ASCII representation of x.
//
void mk_signature( int x, char *sigstr )
{
	sprintf( sigstr, "%d", x );
	qsort( sigstr, strlen(sigstr), sizeof(char), &comparator );
}



//
// bool ispp6 = permuted_perm_6(x);
//	Return true iff x is a permuted_perm_6 number,
//	i.e. that x, 2x, 3x, 4x, 5x and 6x are permuted multiples
//	of each other.  Return false otherwise.
//
bool permuted_perm_6( int x )
{
	char xsig[20];
	mk_signature( x, xsig );
	for( int mult=2; mult<=6; mult++ )
	{
		char xmsig[20];
		mk_signature( x * mult, xmsig );
		if( strcmp( xsig, xmsig ) != 0 ) return false;
	}
	return true;
}


int main( int argc, char **argv )
{
	process_flag_noarg( "permuted-multiples", argc, argv );

	int x;

	for( x = 1; ! permuted_perm_6(x); x++ )
	{
	}

	printf( "%d\n", x );
	return 0;
}
