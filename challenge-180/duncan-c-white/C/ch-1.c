//
// Task 1: First Unique Character
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
// int pos = fuc_pos( s );
//	Find the position of the first unique character in the string s,
//	or -1 if all characters in s are repeated.
//
int fuc_pos( char *s )
{
	int freq[256];	// array over char of int
	for( int i=0; i<256; i++ ) freq[i] = 0;
	for( char *p = s; *p; p++ )
	{
		freq[(int)*p]++;
	}

	int pos = 0;
	for( char *p = s; *p; p++, pos++ )
	{
		if( freq[(int)*p] == 1 )
		{
			return pos;
		}
	}
	return -1;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "fuc", argc, argv,
		1, "String" );
	char *str = argv[argno];

	int pos = fuc_pos( str );
	printf( "%d\n", pos );
	return 0;
}
