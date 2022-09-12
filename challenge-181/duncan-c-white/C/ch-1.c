//
// Task 1: Sentence Order
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
#include "readline.h"
#include "trim.h"


// a word
#define MAXWORDLEN 100
typedef char word[MAXWORDLEN];

// an incomplete sentence: an array of words.
#define MAXWORDS 1000
word wd[MAXWORDS];
int nwords = 0;

// a line can be this long
#define MAXLINELEN 1000

// output stage: lines no more than..
#define OUTLINELEN 62
int linewidth;		// current length of line printed

static int comparewords( const void *a, const void *b)
{
	char *wa = (char *) a;
	char *wb = (char *) b;
	return strcasecmp( wa, wb );
}


//
// deal_with_sentence();
//	deal with the complete sentence in wd[0..nwords-1]
//
static void deal_with_sentence( void )
{
	assert( nwords>0 );

	// sort the words
	qsort( wd, nwords, MAXWORDLEN, &comparewords );

	// add the '.' back to the last word
	char *last = wd[nwords-1];
	int len = strlen(last);
	strcat( last+len, "." );

	if( debug )
	{
		printf( "debug: sorted sentence:" );
		for( int i=0; i<nwords; i++ )
		{
			printf( " %s", wd[i] );
		}
		putchar( '\n' );
	}

	// print out words, controlling the width as we go
	// (recall that linewidth == #chars used on line)
	for( int i=0; i<nwords; i++ )
	{
		int len = strlen( wd[i] );
		if( linewidth + len > OUTLINELEN )	// start a new line
		{
			putchar( '\n' );
			linewidth = 0;
		}
		if( linewidth>0 )		// space-separate words
		{
			putchar( ' ' );
			linewidth++;
		}
		printf( "%s", wd[i] );
		linewidth += len;
	}
}


//
// deal_with_word( wd );
//	we've found a word wd, which may or may not end in
//	a '.'.  deal with it.
//
static void deal_with_word( char *str )
{
	if( debug )
	{
		printf( "debug: found word %s\n", str );
	}
	assert( nwords < MAXWORDS );
	char *w = wd[nwords++];
	strcpy( w, str );
	int len = strlen(w);
	char *last = w+len-1;
	//printf( "debug: word '%s' last char '%c'\n", w, *last );
	if( *last == '.' )
	{
		*last = '\0';

		// found end of sentence.
		deal_with_sentence();

		nwords = 0;
	}
}


int main( int argc, char **argv )
{
	(void)process_flag_n_args( "sentence-order", argc, argv,
		0, "[reads stdin]" );

	nwords = 0;
	linewidth = 0;

	char line[MAXLINELEN];

	while( readline_discardrest( stdin, line, MAXLINELEN ) )
	{
		trim( line );
		if( debug )
		{
			printf( "read line '%s'\n", line );
		}

		// now split line into words
		char *wordstart = line;
		for( char *s = line+1; *s != '\0'; s++ )
		{
			if( ! isspace(*s) ) continue;

			*s = '\0';	// nul-terminate

			deal_with_word( wordstart );

			wordstart = s+1;
		}
		if( *wordstart != '\0' )
		{
			deal_with_word( wordstart );
		}
	}

	if( nwords>0 )
	{
		deal_with_sentence();
	}

	putchar( '\n' );

	return 0;
}
