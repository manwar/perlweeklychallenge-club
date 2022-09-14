//
// Task 2: Common Path
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


#define MAXPATHLEN 1024
typedef char dirpathtype[MAXPATHLEN];


//
// shorten( strpath );
//	Given a writable directory path strpath,
//	modify it to remove the last dirpath part.
//
static void shorten( char *str )
{
	char *s = strrchr( str, '/' );
	assert( s != NULL );
	*s = '\0';
}


//
// int n = countch( s, ch );
//	Count the number of occurrences of ch in s.
//
int countch( char *s, char ch )
{
	int n;
	for( n=0; *s; s++ )
	{
		if( *s == ch ) n++;
	}
	return n;
}


int main( int argc, char **argv )
{
	(void)process_flag_n_args( "common-path", argc, argv,
		0, "[reads stdin]" );

	dirpathtype commonpath;
	(void) readline_discardrest( stdin, commonpath, MAXPATHLEN );
	trim( commonpath );

	if( commonpath[0] != '/' )
	{
		fprintf( stderr, "common-paths: bad directory path '%s'\n",
			commonpath );
		exit(1);
	}

	shorten( commonpath );
	int ncp = countch( commonpath, '/' );

	if( debug )
	{
		printf( "debug: initial commonpath %s has %d slashes\n",
			commonpath, ncp );
	}

	dirpathtype dirpath;
	while( readline_discardrest( stdin, dirpath, MAXPATHLEN ) )
	{
		trim( dirpath );
		if( dirpath[0] != '/' )
		{
			fprintf( stderr, "common-paths: bad directory path '%s'\n",
				dirpath );
			exit(1);
		}

		shorten( dirpath );
		int ndp = countch( dirpath, '/' );

		if( debug )
		{
			printf( "debug: dirpath %s has %d slashes\n",
				dirpath, ndp );
		}

		// need to make dirpath no longer than commonpath
		for( ; ndp > ncp; ndp-- )
		{
			shorten( dirpath );
		}

		if( strcmp( commonpath, dirpath ) != 0 )
		{
			if( debug )
			{
				printf( "debug: found cp %s, shortened "
					"dp %s\n", commonpath, dirpath );
			}

			// try repeatedly removing one dirpath chunk from both
			do {
				shorten( commonpath );
				ncp--;
				shorten( dirpath );
				if( debug )
				{
					printf( "debug: shortened cp to %s, "
						"dp to %s\n", commonpath,
						dirpath );
				}
			} while( strcmp( commonpath, dirpath ) != 0 );
		}
	}

	if( ncp == 0 )
	{
		strcpy( commonpath, "/" );
	}

	printf( "%s\n", commonpath );

	return 0;
}
