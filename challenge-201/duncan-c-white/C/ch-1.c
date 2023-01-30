//
// Task 1: Missing Numbers
// 
// C version.
// we need to simulate a Perl hash-set in C.  for small numbers,
// a bit mask would be fine, eg up to 64 elements.  But we might
// want to solve this for larger N.  We could use an array of ints.
// KISS: let's do a linear search for each desired element.
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


//
// bool ispresent( x, list, nel );
//	Determine whether x is present in list[0..nel-1].
//	Return true if x is present, false otherwise.
//
bool ispresent( int x, int *list, int nel )
{
	for( int i=0; i<nel; i++ )
	{
		if( list[i]==x ) return true;
	}
	return false;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "missing-numbers", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( nel == 0 )
	{
		fprintf( stderr, "missing-numbers: need a list of > 0 elements\n" );
		exit(1);
	}

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	// so range is 0..$nel

	int *missing = malloc( nel * sizeof(int) );
	assert( missing != NULL );
	int nm = 0;

	for( int i=0; i<=nel; i++ )
	{
		if( ! ispresent( i, list, nel ) )
		{
			missing[nm++] = i;
		}
	}
	for( int i=0; i<nm; i++ )
	{
		if( i>0 ) putchar( ',' );
		printf( "%d", missing[i] );
	}
	putchar( '\n' );

	free( missing );
	free( list );

	return 0;
}
