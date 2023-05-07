// Task 2: Number Placement
//
// C translation

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>

#include "args.h"
#include "parseints.h"
#include "printarray.h"


// bool non01 = contains_non_01( string );
//	returns true iff the given string contains any char EXCEPT for 0 or 1.
//
bool contains_non_01( char *string )
{
	for( char *s = string; *s; s++ )
	{
		if( *s != '0' && *s != '1' ) return true;
	}
	return false;
}


// bool canfind = find_pat( startpos, count, bitstring, len );
//	Return true iff we can find the desired pattern (count zeros
//	neither preceded nor followed by a one) in bitstring.
//
bool find_pat( int startpos, int count, char *bitstring, int len )
{
	for( int i=startpos; i<startpos+count; i++ )
	{
		if( bitstring[i] != '0' ) return false;
	}
	if( debug )
	{
		printf( "debug: found zeroes starting at %d\n", startpos );
	}
	if( startpos > 0 )
	{
		char p = bitstring[startpos-1];
		if( p == '1' ) return false;
		if( debug )
		{
			printf( "debug: preceding (%c) is not 1\n", p );
		}
	}
	int followpos = startpos + count;
	if( followpos < len )
	{
		char f = bitstring[followpos];
		if( f == '1' ) return false;
		if( debug )
		{
			printf( "debug: following (%c) is not 1\n", f );
		}
	}
	if( debug )
	{
		printf( "found pattern at startpos %d\n", startpos );
	}

	return 1;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "number-replacement", argc, argv,
		2, "count bitstring" );
	int count = atoi( argv[argno++] );
	char *bitstring = argv[argno];

	if( debug )
	{
		printf( "debug: count=%d, bitstring: %s\n", count, bitstring );
	}

	if( contains_non_01( bitstring ) )
	{
		fprintf( stderr, "number-replacement: bitstring %s must "
				 "only contain 0 and 1\n", bitstring );
		exit(1);
	}

	int len = strlen( bitstring );
	for( int startpos=0; startpos<=len-count; startpos++ )
	{
		if( debug )
		{
			printf( "trying find_pat starting at %d\n", startpos );
		}
		if( find_pat( startpos, count, bitstring, len ) )
		{
			if( debug )
			{
				printf( "succeeded at %d\n", startpos );
			}
			for( int i=0; i<count; i++ ) bitstring[startpos+i] = '1';
			printf( "1 (changed bitstring to %s\n", bitstring );
			exit( 0 );
		}
	}
	printf( "0\n" );
	return 0;
}
