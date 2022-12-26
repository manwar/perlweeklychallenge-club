//
// Task 2: Range List
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
#include "parseints.h"
#include "printarray.h"


typedef char shortstr[10];	// long enough to store a-b string


//
// shortstr *ranges;		// dynamic array of strings
// int nr = 0;
// find_ranges( list, nel, &ranges, &nr );
//	Find and return all ranges of consecutive numbers in @list.
//	Each range is an [from,to] pair.  ranges is a dynarray, which
//	the caller must free.
//
void find_ranges( int *list, int nel, shortstr **ranges, int *nr )
{
	shortstr *r = malloc( nel * sizeof(shortstr) );
	assert( r != NULL );
	*ranges = r;
	*nr = 0;

	int from = -1;
	int to = -1;
	for( int i=0; i<nel; i++ )
	{
		int item = list[i];
		if( from == -1 )		// start first range
		{
			from = item;
			to = item;
			if( debug )
			{
				printf( "debug: item=%d, 1st range %d..%d\n",
					item, from, to );
			}
		} else if( item == to+1 )	// extend current range
		{
			to++;
			if( debug )
			{
				printf( "debug: item=%d, extend range %d..%d\n",
					item, from, to );
			}
		} else				// finish one range, start next
		{
			if( to > from )		// len > 1: add range
			{
				shortstr s;
				sprintf( s, "[%d,%d]", from, to );
				strcpy( r[(*nr)++], s );
				if( debug )
				{
					printf( "debug: item=%d, add range %d..%d\n",
						item, from, to );
				}
			}
			from = item;
			to = item;
			if( debug )
			{
				printf( "debug: item=%d, new range %d..%d\n",
					item, from, to );
			}
		}
	}
	if( to > from )			// len > 1: add range
	{
		shortstr s;
		sprintf( s, "[%d,%d]", from, to );
		strcpy( r[(*nr)++], s );
		if( debug )
		{
			printf( "debug: add final range %d..%d\n", from, to );
		}
	}
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "range-list", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( nel < 3 )
	{
		fprintf( stderr, "range-list: need at least 3 ints in list\n" );
		exit(1);
	}

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	shortstr *ranges;		// dynamic array of strings
	int nr = 0;
	find_ranges( list, nel, &ranges, &nr );
	//printf( "nr=%d, ranges=", nr );
	for( int i=0; i<nr; i++ )
	{
		if( i>0 ) printf( ", " );
		printf( "%s", ranges[i] );
	}
	putchar( '\n' );

	free( ranges );

	free( list );

	return 0;
}
