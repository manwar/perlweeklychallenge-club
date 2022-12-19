//
// Task 2: Most Frequent Even
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


// This time we'll simulate a frequency hash by a list of pairs:
// values x and their frequencies' freq

typedef struct
{
	int x, freq;
} pair;


// int npairs;
// pair *freq = make_freqs( list, nel, &npairs );
//	Given a list of integers (and the number of elements nel)
//	make and return a dynarray of npairs pairs of distinct
//	elements and there frequencies
//
pair *make_freqs( int *list, int nel, int *npairs )
{
	pair *result = malloc( nel * sizeof(pair) );
	assert( result );

	*npairs = 0;

	for( int i=0; i<nel; i++ )
	{
		bool done = false;
		for( int p=0; p<*npairs && !done; p++ )
		{
			if( ! done && list[i] == result[p].x )
			{
				result[p].freq++;
				done = true;
			}
		}
		if( ! done )
		{
			int p = (*npairs)++;
			result[p].x = list[i];
			result[p].freq = 1;
		}
	}

	return result;
}


static int compn(const void *p1, const void *p2)
{
   // The actual arguments to this function are "pointers to ints"
   return (*(int *) p1) - (*(int *) p2);
}


//
// int mfe = mfe( list, nel );
//	Find and return the most-frequent-even number in list[0..nel-1],
//	as documented above.
//
int mfe( int *list, int nel )
{
	// discard odd elements (in place)
	for( int i=0; i<nel; i++ )
	{
		while( i<nel && list[i]%2 == 1 )	// odd
		{
			nel--;
			if( i < nel ) list[i] = list[nel];
		}
	}

	if( debug )
	{
		printf( "debug: even list: nel=%d, list= ", nel );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	if( nel==0 ) return -1;

	int npairs;
	pair *freq = make_freqs( list, nel, &npairs );

	if( debug )
	{
		for( int i=0; i<npairs; i++ )
		{
			printf( "debug: f[%d] = %d\n", freq[i].x, freq[i].freq );
		}
	}

	// find max freq
	int maxfreq = 0;
	for( int i=0; i<npairs; i++ )
	{
		if( freq[i].freq > maxfreq )
		{
			maxfreq = freq[i].freq;
		}
	}

	if( debug )
	{
		printf( "debug, maxfreq=%d\n", maxfreq );
	}

	// find elements with max freq
	int nm = 0;
	int *maxf = malloc( npairs * sizeof(int) );
	assert( maxf );

	for( int i=0; i<npairs; i++ )
	{
		if( freq[i].freq == maxfreq )
		{
			maxf[nm++] = freq[i].x;
		}
	}

	if( debug )
	{
		for( int i=0; i<nm; i++ )
		{
			printf( "debug: mf[%d] = %d\n", i, maxf[i] );
		}
	}

	// sort the values with maximum frequencies
	qsort( maxf, nm, sizeof(int), &compn );

	if( debug )
	{
		printf( "debug: sorted mf[0] = %d\n", maxf[0] );
	}

	int result = maxf[0];

	free( maxf );
	free( freq );

	return result;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "most-freq-even", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( nel < 2 )
	{
		fprintf( stderr, "most-freq-even: need a list of > 1 elements\n" );
		exit(1);
	}

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	int result = mfe( list, nel );

	printf( "%d\n", result );

	free( list );

	return 0;
}
