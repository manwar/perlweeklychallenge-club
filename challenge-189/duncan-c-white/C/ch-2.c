//
// Task 2: Array Degree
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


typedef struct
{
	int el;		// an element
	int freq;	// and it's associated frequency
} pair;


// Increment the frequency of el in freq (adding an element if
// it's not there yet)
static void incfreq( pair *freq, int *np, int el )
{
	for( int i=0; i<*np; i++ )
	{
		if( freq[i].el == el )
		{
			freq[i].freq++;
			return;
		}
	}
	int pos = (*np)++;
	freq[pos].el = el;
	freq[pos].freq = 1;
}


//
// int deg = degree( array, from, to );
//	Calculate the degree (max frequency) of array[from..to].
//
int degree( int *array, int from, int to )
{
	pair *freq = malloc( (to+1-from) * sizeof(pair) );
	assert( freq != NULL );
	int np = 0;	// number of pairs in freq

	for( int i=from; i<=to; i++ )
	{
		incfreq( freq, &np, array[i] );
	}

	// now find the maximum frequency in freq[]
	int max = 0;
	for( int i=0; i<np; i++ )
	{
		if( freq[i].freq > max )
		{
			max = freq[i].freq;
		}
	}
	free( freq );
	return max;
}


// makeslicestr( arr, from, to, slicestr );
//	Build slicestr, a plain text string containing all elements
//	arr[from..to], comma separated
//	Sort of like slicestr = join(',', arr[from..to]);
//
static void makeslicestr( int *arr, int from, int to, char *slicestr )
{
	char *s = slicestr;
	*s = '\0';
	for( int i=from; i<=to; i++ )
	{
		if( i>from )
		{
			*s++ = ',';
		}
		sprintf( s, "%d", arr[i] );
		s += strlen(s);
		*s = '\0';
	}
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "array-degree", argc, argv,
		2, 1000, "csvlist(int)" );
	int nel;
	int *ilist = parse_int_args( argc, argv, argno, &nel );

	if( debug )
	{
		printf( "debug: list=" );
		print_int_array( 70, nel, ilist, ',', stdout );
		putchar( '\n' );
	}

	int wholedeg = degree( ilist, 0, nel-1 );

	char *slicestr = malloc( 10000 * sizeof(char) );
	assert( slicestr != NULL );

	makeslicestr( ilist, 0, nel-1, slicestr );

	if( debug )
	{
		printf( "debug: wholedeg = %d\n", wholedeg );
	}

	char *smallarray = malloc( 10000 * sizeof(char) );
	assert( smallarray != NULL );

	int smallestarraysize = nel+1;

	for( int from=0; from<nel-1; from++ )
	{
		for( int to=from+1; to<nel; to++ )
		{
			int deg = degree( ilist, from, to );
			if( deg != wholedeg ) continue;

			makeslicestr( ilist, from, to, slicestr );
			if( debug )
			{
				printf( "debug: found sub-array %s with degree %d\n", slicestr, deg );
			}

			int size = to+1-from;
			if( size < smallestarraysize )
			{
				smallestarraysize = size;
				strcpy( smallarray, slicestr );
			}
		}
	}

	printf( "%s\n", smallarray );

	free( smallarray );
	free( slicestr );
	free( ilist );

	return 0;
}
