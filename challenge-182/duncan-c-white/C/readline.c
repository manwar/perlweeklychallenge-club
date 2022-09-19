/*
 *   readline.c: utility function readline..
 */

#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <stdlib.h>
#include <stdbool.h>

#include "readline.h"


/*
 * bool lineread = readline( in, buf, maxlen );
 *	read a single line from in (a FILE * open for input)
 *	into a character buffer (char *), reading no more than
 *	maxlen characters, removing a trailing '\n' from the
 *	buffer (if there is one).
 *
 *	return false if EOF, else true if there's a line.
 *
 *	If the input line is longer than that, the REMAINDER OF
 *	THE LINE IS LEFT IN the file's input buffer for later reading.
 *	If readline() is called again immediately, the remainder of
 *	the line will be treated as a separate line.
 *
 *	In caller-space, buf must be a writable character buffer of
 *	size >= maxlen, i.e. typically either a char [n]
 *	or a malloc(n * sizeof(char)) chunk,
 *	where (in both cases) n >= maxlen
 */
bool readline( FILE *in, char *buf, int maxlen )
{
	if( fgets( buf, maxlen, in ) == NULL )
	{
		return false;
	}
	int l = strlen(buf);
	if( l>0 && buf[l-1]=='\n' )
	{
		buf[l-1] = '\0';
	}
	return true;
}


/*
 * bool lineread = readline_discardrest( in, buf, maxlen );
 *	read a single line from in (a FILE * open for input)
 *	into a character buffer (char *), reading no more than
 *	maxlen characters, removing a trailing '\n' from the
 *	buffer (if there is one).
 *
 *	return false if EOF, else true if there's a line.
 *
 *	If the input line is longer than that, the REMAINDER OF
 *	THE LINE IS DISCARDED.
 *
 *	In caller-space, buf must be a writable character buffer of
 *	size >= maxlen, i.e. typically either a char [n]
 *	or a malloc(n * sizeof(char)) chunk,
 *	where (in both cases) n >= maxlen
 */
bool readline_discardrest( FILE *in, char *buf, int maxlen )
{
	if( fgets( buf, maxlen, in ) == NULL )
	{
		return false;
	}
	int l = strlen(buf);
	if( l>0 && buf[l-1]=='\n' )
	{
		buf[l-1] = '\0';
	} else
	{
		while( getchar() != '\n' ) /*EMPTY*/;
	}
	return true;
}
