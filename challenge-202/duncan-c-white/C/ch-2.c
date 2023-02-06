//
// Task 2: Widest Valley
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


// int len = find_valley( spos, list, nel );
//	find the leftmost longest sequence of one or more adjacent numbers
//	where initially the numbers go down (or stay the same) and then they
//	go up (or stay the same).
//
int find_valley( int spos, int *list, int nel )
{
	int curr = list[spos];
	int p = spos+1;
	for( ; p<nel && list[p] <= curr; curr=list[p++] )
	{
	}
	for( ; p<nel && list[p] >= curr; curr=list[p++] )
	{
	}
	if( debug )
	{
		printf( "debug: found valley from pos %d to pos %d\n",
			spos, p-1 );
	}
	return p-spos;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "widest-valley", argc, argv,
		1, 1000, "intlist" );
	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( nel == 0 )
	{
		fprintf( stderr, "widest-valley: need a list of > 0 elements\n" );
		exit(1);
	}

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	int maxw = 0;
	int maxw_spos = 0;

	for( int spos=0; spos<nel; spos++ )
	{
		int w = find_valley( spos, list, nel );
		if( w > maxw )
		{
			if( debug )
			{
				printf( "debug: found new widest valley "
					"starting at %d: width %d\n", spos, w );
			}
			maxw = w;
			maxw_spos = spos;
		}
	}

	for( int i=0; i<maxw; i++ )
	{
		if( i>0 ) printf( ", " );
		printf( "%d", list[maxw_spos+i] );
	}
	putchar( '\n' );

	free( list );
	return 0;
}
