//
// Task 2: Decoded List
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


typedef char bigstr[1024];


char enc[27];	// element 0 not used


//
// decode_all( str, prefix, results[], &nr );
//	Decode str, taking 1 or 2 digits off the front (as long
//	as the number that results is between 1..26), producing
//	all the possible decodings (adding prefix to each decoding
//	that we produce)
//
void decode_all( char *str, char *prefix, bigstr *results, int *nr )
{
	if( *str == '\0' )
	{
		int i = (*nr);
		strcpy( results[i], prefix );
		if( debug )
		{
			printf( "found solution %d = %s\n", i, prefix );
		}
		(*nr)++;
		return;
	}

	// try taking off the first char..
	char first = *str;
	char *rem = str+1;
	if( debug )
	{
		printf( "debug: first=%c, rem=%s\n", first, rem );
	}
	if( strcmp(rem,"0") != 0 && first != '0')
	{
		bigstr p2;
		strcpy( p2, prefix );
		char *p = p2+strlen(p2);
		*p++ = enc[first-'0'];
		*p++ = '\0';
		if( debug )
		{
			printf( "debug: recurse with rem=%s, first=%c, prefix=%s\n",
				rem, first, p2 );
		}
		decode_all( rem, p2, results, nr );
	}

	if( strlen(str) > 1 )
	{
		// try taking off the first two chars..
		int first = (*str-'0')*10 + (str[1]-'0');
		char *rem = str+2;
		if( debug )
		{
			printf( "debug: first=%d, rem=%s\n", first, rem );
		}

		if( strcmp(rem,"0") != 0 && first <= 26 )
		{
			bigstr p2;
			strcpy( p2, prefix );
			char *p = p2+strlen(p2);
			*p++ = enc[first];
			*p++ = '\0';
			if( debug )
			{
				printf( "debug: recurse with rem=%s, first=%d, prefix=%s\n",
					rem, first, p2 );
			}
			decode_all( rem, p2, results, nr );
		}
	}
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "decoded-list", argc, argv,
		1, "encoded string" );

	char *str = argv[argno++];

	if( debug )
	{
		printf( "debug: str=%s\n", str );
	}

	for( char ch='A'; ch<='Z'; ch++ )
	{
		enc[ch-'@'] = ch;
		if( debug )
		{
			printf( "debug: enc[%d] = %c\n", ch-'@', ch );
		}
	}


	bigstr results[1024];
	int nr = 0;
	decode_all( str, "", results, &nr );

	bool first = true;
	for( int i=0; i<nr; i++ )
	{
		if( ! first )
		{
			fputs( ", ", stdout );
		}
		printf( "%s", results[i] );
		first = false;
	}
	putchar( '\n' );

	return 0;
}
