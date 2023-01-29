//
// Task 2: Penny Piles
// 
// C version.
// The main challenge here is to represent the ways (in Perl a list-of-lists).
// As we want to display each way (inner list) comma separated, let's build
// that, i.e. way == string.  How long a string?  1 + 2 * initial n is long
// enough for the 1-1-1-...-1 (n ones) way, which is the longest one.
// So now we just need to store a dynarray of strings.
// 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>

#include "args.h"
#include "parseints.h"
#include "printarray.h"


typedef struct {
	int n;	     // number of elements.
	int nalloc;  // number of elements allocated (nalloc >= n)
	char **d;    // block to store up to <nalloc> elements, of which
		     // the first <n> are in use at present.
} dynarray;


void init_dynarray( dynarray *d )
{
	d->n = 0;
	d->nalloc = 10;
	d->d = malloc( d->nalloc * sizeof(char *) );
	assert( d->d != NULL );
}


void add_element( dynarray *d, char *e )
{
	if( debug )
	{
		printf( "debug: adding element %s\n", e );
	}
	d->d[d->n] = strdup(e);
	d->n++;
	if( d->n == d->nalloc )
	{
		d->nalloc += 10;
		d->d = realloc( d->d, d->nalloc * sizeof(char *) );
		assert( d->d != NULL );
	}
}


void free_dynarray( dynarray *d )
{
	if( d->d != NULL )
	{
		for( int i=0; i<d->n; i++ )
		{
			free( d->d[i] );
		}
		free( d->d );
	}
	d->d = NULL;
}


//
// char *oldp = append_prefix( prefix, x );
//	Given a prefix string (that's got space)
//	and an int x, append ",x" onto the prefix.
//	Return the pointer into the prefix string
//	where we have just appended a value.
//
char *append_prefix( char *prefix, int n )
{
	char *origp = prefix + strlen(prefix);
	char *p = origp;
	if( p > prefix )
	{
		*p++ = ',';
		*p = '\0';
	}
	sprintf( p, "%d", n );
	return origp;
}


//
// dynarray ways;
// init_dynarray( &ways );
// penny( n, min, prefix, &ways );
//	Calculate all the different ways of penny-allocating $n,
//	according to the rules at the top, appending all such ways
//	found to ways, a dynarray of strings, in which the prefix is
//	prepended to every way found.
//
void penny( int n, int min, char *prefix, dynarray *ways )
{
	if( n < min ) return;

	if( n==min )
	{
		char *oldp = append_prefix( prefix, n );
		add_element( ways, prefix );
		*oldp = '\0';
		return;
	}

	for( int i=min; i<n; i++ )
	{
		if( n-i >= min )
		{
			char *oldp = append_prefix( prefix, i );
			penny( n-i, i, prefix, ways );
			*oldp = '\0';
		}
	}

	// i==n case:
	if( n >= min )
	{
		char *oldp = append_prefix( prefix, n );
		add_element( ways, prefix );
		*oldp = '\0';
	}
}


int main( int argc, char **argv )
{
	int arg = process_flag_n_args( "penny-piles", argc, argv, 1, "int" );

	int n = atoi( argv[arg] );

	if( n <= 0 )
	{
		fprintf( stderr, "penny-piles: N (%d) must be > 0\n", n );
		exit(1);
	}

	if( debug )
	{
		printf( "debug: n=%d\n", n );
	}

	int prefsize = 2*n*sizeof(char) + 1;
	char *prefix = malloc( prefsize );
	assert( prefix != NULL );
	memset( prefix, '\0', prefsize );

	dynarray ways;
	init_dynarray( &ways );
	penny( n, 1, prefix, &ways );

	int nways = ways.n;
	printf( "%d\n", nways );

	printf( "ways:\n" );
	for( int i=0; i<nways; i++ )
	{
		printf( "%s\n", ways.d[i] );
	}

	free( prefix );

	free_dynarray( &ways );

	return 0;
}
