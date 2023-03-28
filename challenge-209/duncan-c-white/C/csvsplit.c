//
// csvsplit.c: simple CSV splitting (csvForeach), useful utility functions
//	       Now one function that strdup()s it's strings, another that
//	       modifies them in place.
//
// (C) Duncan C. White, May 2017-March 2023

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <assert.h>

#include "csvsplit.h"


// csvForeach( csvstring, &foreach_callback, (void *)extravalue );
//	Split csvstring (modifying it in place) into each comma-separated field,
//	calling the foreach calback for each comma-separated field, passing the
//	value and extravalue as parameters to it.  It doesn't deal
//	with commas in quoted strings, however.
//
void csvForeach( char *csvstring, csvforeachcb cb, void *extra )
{
	char *start = csvstring;
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
}


// csvForeachstrdup( csvstring, &foreach_callback, (void *)extravalue );
//	Split csvstring into each comma-separated field, duplicating it
//	in order to modify the copy, calling the foreach calback for each
//	comma-separated field it finds, passing the value and extravalue as
//	parameters to it.  It doesn't deal with commas in quoted strings, however.
//
void csvForeachstrdup( char *csvstring, csvforeachcb cb, void *extra )
{
	// make a modifiable copy..
	char *copy = strdup( csvstring );
	assert( copy != NULL );

	csvForeach( copy, cb, extra );

	// don't forget to..
	free( copy );
}
