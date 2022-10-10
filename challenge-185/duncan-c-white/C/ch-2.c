//
// Task 2: Mask Code
//	(without the "--firstn N" option)
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


//
// mask( code, n );
//	Perform the masking as specified above to code.
//
void mask( char *code, int firstn )
{
	int found = 0;
	int len = strlen(code);
	for( int pos=0; pos<len && found<firstn; pos++ )
	{
		if( isalnum(code[pos]) )
		{
			code[pos] = 'x';
			found++;
		}
	}
}


const int firstn = 4;


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "mask-code", argc, argv,
		1, 100000, "array of code-strings" );

	int numstrings = argc-argno;
	if( debug )
	{
		printf( "debug: numstrings=%d\n", numstrings );
	}

	int i;
	bool first=true;
	for( i=argno; i<argc; i++ )
	{
		char code[100];
		strcpy( code, argv[i] );
		mask( code, firstn );
		printf( "%s", code );
		if( first ) putchar( ',' );
		first = false;
	}

	putchar('\n');

	return 0;
}
