//
// Task 2: Trim List
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
#include "prarray.h"
#include "parseints.h"


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "trim-list", argc, argv,
		2, 1024, "I ListofIntegers" );
	char *arg = argv[argno++]; // I

	int x;
	if( !check_unsigned_int(arg,&x) )
	{
		fprintf( stderr, "trim-list: arg %s must be +int\n", arg );
		exit(1);
	}

	// all remaining arguments should be single ints, or
	// comma-separated lists of ints.  Accumulate them in a single list
	// (terminated by a -1).
	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	// now trim, i.e. select only those elements >= x.
	// could do it in place, but it's easier to copy the elements out.
	int trimmed[nel+1];
	int *dst = trimmed;
	int ndst = 0;

	for( int *l=list; *l != -1; l++ )
	{
		if( *l >= x )
		{
			*dst++ = *l;
			ndst++;
		}
	}

	free( list );

	putchar( '(' );
	print_int_array( 80, ndst, trimmed, stdout );
	putchar( ')' );
	putchar( '\n' );

	return 0;
}
