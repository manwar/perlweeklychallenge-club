/*
 * csvsplit.c: simple CSV splitting (csvForeach), useful utility function
 *
 * (C) Duncan C. White, May 2017
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <assert.h>

#include "csvsplit.h"


/*
 * csvForeach( csvstring, &foreach_callback, (void *)extravalue );
 *	Split csvstring into each comma-separated field, calling the
 *	foreach calback for each comma-separated field, passing the
 *	value and extravalue as parameters to it.  It doesn't deal
 *	with commas in quoted strings, however.
 */
void csvForeach( char *csvstring, csvforeachcb cb, void *extra )
{
	// we need to modify the string, so make a mutable copy..
	char *copy = strdup( csvstring );

	char *start = copy;
	for(;;)
	{
		char *comma=strchr( start, ',' );
		if( comma != NULL )
		{
			// found the first comma after start
			*comma = '\0';
		}
		//printf( "debug: csvForeach: found value %s\n", start );
		(*cb)( start, extra );

	if( comma == NULL ) break;

		// move start to one beyond where comma was..
		start = comma+1;
	}
	// don't forget to..
	free( copy );
}
