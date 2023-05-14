// Task 1: Registration Number
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


//
// bool containsall = wordcontainsall( word, set );
//	Return true iff word contains every letter in set.
//
bool wordcontainsall( char *word, char *set )
{
	for( ; *set; set++ )
	{
		char letter = *set;
		if( isupper(letter) ) letter = tolower(letter);
		if( strchr( word, letter ) == NULL ) return false;
	}
	return true;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "reg-nos", argc, argv,
		2, 1000, "reg wordlist" );

	char *reg = argv[argno++];

	if( debug )
	{
		printf( "debug: reg: %s, list: ", reg );
		for( int i=argno; i<argc; i++ )
		{
			if( i>argno ) putchar( ',' );
			printf( "%s", argv[i] );
		}
		putchar( '\n' );
	}

	char regset[argc+1];
	char *d = regset;
	for( char *s = reg; *s; s++ )
	{
		if( ! isalpha(*s) ) continue;
		if( strchr(regset, *s) == NULL )
		{
			*d++ = *s;
			*d = '\0';
		}
	}

	if( debug )
	{
		printf( "debug: regset=%s\n", regset );
		//exit(1);
	}

	int n = 0;
	for( int i=argno; i<argc; i++ )
	{
		char *word = argv[i];
		if( wordcontainsall( word, regset ) )
		{
			if( n>0 ) putchar( ',' );
			n++;
			printf( "%s", word );
		}
	}
	putchar( '\n' );

	return 0;
}
