//
// Task 2: Odd Strings
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
// char *diffsig = diffsig(str);
//
// Given an alphabetic string $str, form and return the difference signature.
// (a malloc()d string, the caller is responsible for freeing it later).
//
char * diffsig( char *str )
{
	int len = strlen(str);
	assert( len > 1 );
	char *result = malloc( 4 * len + 2 );	// 4 * len: optional -, 1 or 2
						// digits and a comma:
						// then add a bit:-)
	assert( result != NULL );

	char *rp = result;	// rp will walk the result, appending chars
	*rp = '\0';		// let's keep it nul-terminated always

	// foreach char *p that is not the last
	for( char *p=str; *(p+1) != '\0'; p++ )
	{
		if( p>str ) *rp++ = ',';
		sprintf( rp, "%d", *(p+1)-*p );
		while( *rp != '\0' ) rp++;
	}

	//printf( "debug: diffstr(%s) = %s\n", str, result );
	return result;
}


//
// lowercase(str);
//	lowercase str in place.
//
void lowercase( char *str )
{
	for( char *p=str; *p; p++ )
	{
		*p = tolower(*p);
	}
}


// a (string, diffsig) pair
typedef struct
{
	char *str;
	char *sig;
} pair;


// qsort comparator for a pair.. couldn't resist the name..
static int compair( const void *a, const void *b )
{
	pair *p = (pair *)a;
	pair *q = (pair *)b;
	return strcmp( p->sig, q->sig );
}


// a ptr to a function taking a signature and list[from]..list[to]
// comprising all the strings with that signature.
typedef void (*sigcallback)( char *sig, pair *list, int from, int to );


//
// find_freq_sigs( list, nel, cb );
//	given a sorted list of nel pairs, locate each set of strings
//	with distinct signatures, and call the cb function for each
//	set found.
//
void find_freq_sigs( pair *list, int nel, sigcallback cb )
{
	char *sig = "";
	int from = -1;
	int to = -1;
	for( int i=0; i<nel; i++ )
	{
		if( strcmp( sig, list[i].sig ) != 0 )
		{
			// found different signature list[i].sig
			// deal with previous set
			if( *sig != '\0' )
			{
				(*cb)( sig, list, from, to );
			}

			from = i;
			to = i;
			sig = list[i].sig;
		} else
		{
			to++;
		}
	}
	// deal with final set
	if( *sig != '\0' )
	{
		(*cb)( sig, list, from, to );
	}
}


static void printsigset( char *sig, pair *list, int from, int to )
{
	int freq = to-from+1;
	//printf( "sig %s: list[%d]=%s..list[%d]=%s, freq %d\n",
	//	sig, from, list[from].str, to, list[to].str, freq );
	if( freq == 1 )
	{
		if( debug )
		{
			printf( "unique sig %s: %s\n", sig, list[from].str );
		} else
		{
			printf( "%s\n", list[from].str );
		}
	}
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "odd-strings", argc, argv,
		1, 100, "strlist" );

	if( debug )
	{
		printf( "debug: argno=%d, argc=%d\n", argno, argc );
	}

	pair list[argc-argno];		// list[i-argno].str : argv[i],
					// list[i-argno].sig : diffsig(lc(argv[i]))

	// build list.. indexes 0..argc-argno-1
	int nel=0;
	for( int i=argno; i<argc; i++ )
	{
		list[nel].str = strdup(argv[i]);
		lowercase(list[nel].str);
		list[nel].sig = diffsig(list[nel].str);
		if( debug )
		{
			printf( "debug: unsorted list[%d].str=%s, "
			        "list[%d].sig=%s\n",
				nel, list[nel].str,
				nel, list[nel].sig );
		}
		nel++;
	}

	if( debug )
	{
		printf( "debug: nel=%d\n", nel );
	}

	// sort list by signature
	qsort( list, nel, sizeof(pair), &compair );

	// show sorted list
	if( debug )
	{
		for( int i=0; i<nel; i++ )
		{
			printf( "debug: sorted list[%d].str=%s, "
			        "list[%d].sig=%s\n",
				i, list[i].str, i, list[i].sig );

		}
	}

	if( debug ) putchar( '\n' );
	find_freq_sigs( list, nel, &printsigset );

	// tidy up.. free everything we malloc()d
	for( int i=0; i<nel; i++ )
	{
		free( list[i].sig );
		free( list[i].str );
	}

	return 0;
}
