//
// Task 1: Special Bit Characters
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


// decode( bitlist );
//	apply the decoding rules to bitlist, modifying it.
//
void decode( char *bitlist )
{
	// decode
	bool changed = false;
	do
	{
		changed = false;

		// decode 10 -> b
		char *p = strstr( bitlist, "10" );
		if( p != NULL )
		{
			printf( "found 10 in bitlist at %s, rewriting as b\n", p );
			*p = 'b';
			// shift rest of bitlist up one pos
			for( char *s = p+1; (*s = *(s+1)) != '\0'; s++ ) /*EMPTY*/;
			printf( "shifted bitlist up one %s\n", bitlist );
			changed = true;
			continue;
		}
		// decode 11 -> c
		p = strstr( bitlist, "11" );
		if( p != NULL )
		{
			printf( "found 11 in bitlist at %s, rewriting as c\n", p );
			*p = 'c';
			// shift rest of bitlist up one pos
			for( char *s = p+1; (*s = *(s+1)) != '\0'; s++ ) /*EMPTY*/;
			printf( "shifted bitlist up one %s\n", bitlist );
			changed = true;
			continue;
		}
		// decode 0 -> a
		p = strchr( bitlist, '0' );
		if( p != NULL )
		{
			printf( "found 0 in bitlist at %s\n", p );
			*p = 'a';
			printf( "altered bitlist to %s\n", bitlist );
			changed = true;
			continue;
		}

	} while( changed );
	printf( "modified bits: %s\n", bitlist );
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "spc", argc, argv,
		1, "bitlist" );

	char *bitlist = argv[argno];

	if( debug )
	{
		printf( "bitlist: %s\n", bitlist );
	}
	bool ok = true;
	char badbit = 'a';
	for( char *s=bitlist; *s; s++ )
	{
		if( *s != '0' && *s != '1' )
		{
			ok = false;
			badbit = *s;
		}
	}
	if( ! ok )
	{
		fprintf( stderr, "bad bit %c in %s\n", badbit, bitlist );
		exit(1);
	}

	decode( bitlist );

	if( debug )
	{
		printf( "decoded bits: %s\n", bitlist );
	}

	int len = strlen(bitlist);
	printf( "%d\n", bitlist[len-1] == 'a' ? 1 : 0 );
	return 0;
}
