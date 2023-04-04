//
// Task 2: Number Collision
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
// int pos = find_pos_neg( nel, list );
//	Search in the given list[nel] for a positive number
//	immediately followed by a negative number.
//	If you find such a pair return the position of
//	the positive number.
//	If there is no such pair, return -1.
//
int find_pos_neg( int nel, int *list )
{
	for( int i=0; i<nel-1; i++ )
	{
		if( list[i]>=0 && list[i+1]<0 )
		{
			return i;
		}
	}
	return -1;
}


//
// int newnel = remove_elements( nel, list, delpos, ndel );
//	Delete ndel elements starting at delpos from list[nel],
//	returning the new number of elements (should be nel-ndel)
//
int remove_elements( int nel, int *list, int delpos, int ndel )
{
	if( debug )
	{
		// give ourselves a new array containing the deleted elements
		int *deleted = malloc( nel * sizeof(int) );
		assert( deleted != NULL );
		int ndeleted = 0;

		for( int i=delpos; i<delpos+ndel; i++ )
		{
			deleted[ndeleted++] = list[i];
		}
		printf( "debug: deleting %d elements starting at pos %d: ",
			ndel, delpos );
		print_int_array( 60, ndeleted, deleted, ',', stdout );
		putchar( '\n' );

		free( deleted );
	}

	for( int i=delpos+ndel; i<nel; i++ )
	{
		list[i-ndel] = list[i];
	}

	return nel-ndel;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "number-collision", argc, argv,
		1, 1000, "intlist" );
	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	for( int round = 1;  ; round++ )
	{
		int pos = find_pos_neg( nel, list );
		if( debug )
		{
			printf( "round %d: list = ", round );
			print_int_array( 60, nel, list, ',', stdout );
			printf( " pos = %d\n", pos );
		}
	if( pos == -1 ) break;

		int a = list[pos];
		int b = list[pos+1];
		if( debug )
		{
			printf( "debug: elements %d and %d collide\n", a, b );
		}
		int ma = a;
		int mb = abs(b);
		int rempos = pos;		// remove which starting position?
		int nrem = 1;			// how many to remove?
		if( ma == mb )			// remove both
		{
			if( debug )
			{
				printf( "debug: both elements %d and %d "
					"explode\n", a, b );
			}
			rempos = pos;
			nrem = 2;
		} else if( ma > mb )
		{
			if( debug )
			{
				printf( "debug: element %d explodes\n", b );
			}
			rempos = pos+1;
		} else
		{
			if( debug )
			{
				printf( "debug: element %d explodes\n", a );
			}
		}

		// Remove nrem elements starting at rempos from list[nel]
		nel = remove_elements( nel, list, rempos, nrem );

		if( debug )
		{
			printf( "end of round %d: list = ", round );
			print_int_array( 60, nel, list, ',', stdout );
			putchar( '\n' );
		}
	}

	print_int_array( 60, nel, list, ',', stdout );
	putchar( '\n' );
	return 0;
}
