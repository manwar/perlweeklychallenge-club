/* 
 * Task 2 - Sylvester's sequence
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-2.pl.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>
#include <ctype.h>

// let's use the Gnu Multi Precision library
#include <gmp.h>

#include "args.h"


int main( int argc, char **argv )
{
	int n;
	process_onenumarg_default( "sylvester-numbers", argc, argv, 10, &n );

	// set p to 2
	mpz_t p;
	mpz_init_set_str( p, "2", 10 );

	// sigh: need "one"
	mpz_t one;
	mpz_init_set_str( one, "1", 10 );

	puts( "2" );

	mpz_t next;
	mpz_init( next );

	for( int i; i<n-1; i++ )
	{
		// set next to p + 1;
		mpz_add( next, p, one );

		// print next:
		char *buf;
		buf = mpz_get_str( NULL, 10, next );
		puts( buf );
		free( buf );

		// p *= next;
		mpz_mul( p, p, next );
	}
	mpz_clear( next );
	mpz_clear( p );
	mpz_clear( one );
	return 0;
}
