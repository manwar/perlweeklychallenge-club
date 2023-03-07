//
// Task 2: Array Pairings
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


#define MAXSOLS 128


//
// find_all( sum, solarray, &nsol, list, nel );
//	Given an even-length list list[0..nel-1], a sum so far (sum),
//	an array of solutions (solarray) and a pointer to the number of
//	solutions (nsol), pick all possible pairs of items from list
//	including the first item in the list, and min(that pair) to the sum,
//	and recurse on the rest of the array.  Accumulate all solutions
//	(the final value of sum when list is empty) in solarray[].
//
void find_all( int sum, int *solarray, int *nsols, int *list, int nel )
{
	if( nel == 0 )
	{
		int n = (*nsols)++;
		assert( n < MAXSOLS );
		solarray[n] = sum;
		return;
	}

	// find all pairs of first item, another item in @list
	int first = list[0];
	for( int spos = 1; spos<nel; spos++ )
	{
		int second = list[spos];
		int min = first<second ? first : second;
		int news = sum + min;
		if( debug )
		{
			printf( "debug: removed %d and %d (min %d, newsum %d) ",
				first, second, min, news );
		}

		// now remove elements 0 and spos from a clone of list..
		int *newl = malloc( nel * sizeof(int) );
		assert( newl != NULL );
		int newn = 0;
		for( int i=1; i<nel; i++ )
		{
			if( i != spos ) newl[newn++] = list[i];
		}
		if( debug )
		{
			printf( "leaving " );
			for( int i=0; i<newn; i++ )
			{
				if( i>0 ) putchar(',');
				printf( "%d", newl[i] );
			}
			putchar( '\n' );
		}
		find_all( news, solarray, nsols, newl, newn );
		free( newl );
	}
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "array-pairings", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( nel % 2 == 1 )
	{
		fprintf( stderr, "array-pairings: need even number of integers, not %d\n", nel );
		exit(1);
	}

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	int solutions[MAXSOLS];	// list of all solutions, final answer is max(these)
	int nsols = 0;

	find_all( 0, solutions, &nsols, list, nel );

	if( debug )
	{
		printf( "debug: pairing solutions: nsols=%d, ", nsols );
		for( int i=0; i<nsols; i++ )
		{
			if( i>0 ) putchar( ',' );
			printf( "%d", solutions[i] );
		}
		putchar( '\n' );
	}

	int max = solutions[0];
	for( int i=1; i<nsols; i++ )
	{
		if( solutions[i] > max ) max = solutions[i];
	}
	printf( "%d\n", max );

	free( list );

	return 0;
}
