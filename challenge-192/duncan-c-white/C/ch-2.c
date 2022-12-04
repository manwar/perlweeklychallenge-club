//
// Task 2: Equal Distribution
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


//
// int pos = find_pair_diff_gt_1(nel, list[]);
//	Find the position pos of the first element of the first pair in list
//	where the absolute difference between list[pos] and list[pos+1] is > 1.
//	Return -1 if none.
//
int find_pair_diff_gt_1( int nel, int *list )
{
	for( int pos=0; pos<nel-1; pos++ )
	{
		if( abs( list[pos] - list[pos+1] ) > 1 ) return pos;
	}
	return -1;
}


//
// int pos = find_pair_f_lt_s(nel, list[]);
//	Find the position pos of the first element of a pair in @list
//	where list[$pos] < list[pos+1].  Return -1 if none.
//
int find_pair_f_lt_s( int nel, int *list )
{
	for( int pos=0; pos<nel-1; pos++ )
	{
		if( list[pos] < list[pos+1] ) return pos;
	}
	return -1;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "equal-distribution", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( nel < 2 )
	{
		fprintf( stderr, "equal-distribution: need a list of > 1 elements\n" );
		exit(1);
	}

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	int nmoves = 0;

	if( debug )
	{
		printf( "starting first pass\n" );
	}

	// first pass: repeatedly find two adjacent cells whose absolute
	// difference > 1 and transfer one from the bigger to the smaller.
	int pos;
	while( (pos = find_pair_diff_gt_1(nel, list)) != -1 )
	{
		if( debug )
		{
			printf( "debug: found pos %d, list=", pos );
			print_int_array( 60, nel, list, ',', stdout );
			putchar( '\n' );
		}
		if( list[pos] < list[pos+1] )
		{
			list[pos]++;
			list[pos+1]--;
		} else
		{
			list[pos]--;
			list[pos+1]++;
		}
		nmoves++;
	}

	if( debug )
	{
		printf( "starting second pass\n" );
	}

	// second pass: repeatedly find 2 adjacent cells where
	// firstvalue < secondvalue and transfer one from secondvalue
	// to firstvalue
	while( (pos = find_pair_f_lt_s(nel, list)) != -1 )
	{
		if( debug )
		{
			printf( "debug: found pos %d, list=", pos );
			print_int_array( 60, nel, list, ',', stdout );
			putchar( '\n' );
		}
		list[pos]++;
		list[pos+1]--;
		nmoves++;
	}

	int firstel = list[0];
	int nsame = 0;
	for( pos=0; pos<nel; pos++ )
	{
		if( list[pos] == firstel ) nsame++;
	}
	bool success = nsame == nel;

	if( debug )
	{
		printf( "debug: after %d moves, nsame=%d, success=%d, "
			"final list=", nmoves, nsame, success );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}
	printf( "%d\n", success ? nmoves : -1 );

	free( list );

	return 0;
}
