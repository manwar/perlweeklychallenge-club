//
// Task 1: Keyboard Word
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


// bool matched = matchoneofchar( ch, chars );
//	Find whether or not <ch> is any of the characters from <chars>.
//	Return true iff it does.
//
bool matchoneofchar( char ch, char *s )
{
	for( ; *s; s++ )
	{
		if( *s == tolower(ch) ) return true;
	}
	return false;
}


// bool matched = match( w, chars );
//	Find whether or not <w> matches only characters from <chars>.
//	Return true iff it does.
//
bool match( char *w, char *chars )
{
	for( ; *w; w++ )
	{
		if( !matchoneofchar( *w, chars ) ) return false;
	}
	return true;
}


// bool matched = matchword( w );
//	Find whether or not <w> matches any of the keyboard rows.
//	Return true iff it does.
//
bool matchword( char *w )
{
	if( match( w, "qwertyuiop" ) ) return true;
	if( match( w, "asdfghjkl" ) ) return true;
	if( match( w, "zxcvbnm" ) ) return true;
	return false;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "keyboard-word", argc, argv,
		1, 1000, "wordlist" );

	int nel = argc-argno;

	if( debug )
	{
		printf( "debug: initial list: nel=%d, ", nel );
		for( int i=argno; i<argc; i++ )
		{
			if( i>argno ) putchar(',');
			printf( "%s", argv[i] );
		}
		putchar( '\n' );
	}

	printf( "(" );
	bool first = true;
	for( int i=argno; i<argc; i++ )
	{
		if( matchword( argv[i] ) )
		{
			if( !first ) putchar(',');
			first = false;
			printf( "\"%s\"", argv[i] );
		}
	}
	printf( ")\n" );

	return 0;
}
