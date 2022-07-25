/* 
 * Task 1 - Esthetic Number
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-1.pl.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
//#include <stdint.h>
#include <string.h>
#include <assert.h>

#include "args.h"



//
// bool isesth = is_esthetic( n, msgbuf, bufsize );
//	Determine whether n is esthetic, returning the
//	boolean answer to the question "is it esthetic?",
//	and using msgbuf (a writable string buf of size bufsize)
//	to store a printable explanation of why - or why not -
//	n is esthetic, in the above format.
//	|5 - 4| = |4 - 5| = |5 - 6| = 1
//	or |2 - 0| != 1
//
bool is_esthetic( int n, char *msgbuf, int bufsize )
{
	if( n<10 )
	{
		assert( bufsize>20 );
		strcpy( msgbuf, "because no single digit is" );
		return 0;
	}

	// convert n to string form (for easier access to digits)
	char dig[100];
	sprintf( dig, "%d", n );
	int ndig = strlen(dig);

	// look for any pair of digits not differing by 1
	for( int i=0; i<ndig-1; i++ )
	{
		char a = dig[i];
		char b = dig[i+1];
		if( abs(a-b) != 1 )
		{
			assert( bufsize>20 );
			sprintf( msgbuf, "|%c - %c| != 1", a, b );
			return 0;
		}
	}

	// ok, all pairs of digits differ by 1.. form msgbuf
	strcpy( msgbuf, "" );
	int mlen = 0;
	for( int i=0; i<ndig-1; i++ )
	{
		char a = dig[i];
		char b = dig[i+1];
		char msg[100];
		sprintf( msg, "|%c - %c| = ", a, b );
		mlen += strlen(msg);
		assert( mlen < bufsize );
		strcat( msgbuf, msg );
	}
	mlen += 4;
	assert( mlen < bufsize );
	strcat( msgbuf, "1" );
	return 1;
}


int main( int argc, char **argv )
{
	int n;
	process_onenumarg( "esthetic-number", argc, argv, &n );

	char msg[1024];
	bool isesth = is_esthetic( n, msg, sizeof(msg) );
	if( debug )
	{
		char *not = isesth ? "": " not";
		printf( "%d is%s an esthetic number as %s\n", n, not, msg );
	} else
	{
		puts( isesth ? "yes" : "no" );
	}
	return 0;
}
