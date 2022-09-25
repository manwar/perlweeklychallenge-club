//
// Task 1: Unique Array
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


typedef struct { int nel; int *list; } sizedarray;


//
// sizedarray a = ...;
// sizedarray b = ...;
// bool issame = same_list( &a, &b );
//	Return true iff a and b are the same list; else return false.
//
static bool same_list( sizedarray *a, sizedarray *b )
{
	if( a->nel != b->nel ) return false;
	for( int i=0; i<a->nel; i++ )
	{
		if( a->list[i] != b->list[i] ) return false;
	}
	return true;
}


// sizedarray lists[nlists] = ...;
// int dup = find_dup( lists, lno, nlists );
//	Determine whether lists[lno] has any duplicates in
//	lists[lno+1..nlists-1], return the duplicate list index no
//	if it does, or -1 if it doesn't.
static int find_dup( sizedarray *lists, int lno, int nlists )
{
	for( int i=lno+1; i<nlists; i++ )
	{
		if( same_list( &lists[lno], &lists[i] ) )
		{
			return i;
		}
	}
	return -1;
}


// sizedarray lists[nlists] = ...;
// remove_duplicate_arrays( lists, &nlists );
//	Remove all duplicate arrays from lists[0..nlists-1],
//	modifying both lists[] and the value of nlists.
static void remove_duplicate_arrays( sizedarray *lists, int *nlists )
{
	for( int i=0; i<*nlists; i++ )
	{
		// while lists[i] has a duplicate in lists[i+1..]
		int dup;
		while( (dup = find_dup( lists, i, *nlists )) != -1 )
		{
			if( debug )
			{
				printf( "rda: list[%d] is duplicate of list[%d], deleting list[%d]\n",
					dup, i, dup );
			}
			// delete lists[dup] by shifting lists[dup+1..] down
			for( int j=dup+1; j<*nlists; j++ )
			{
				lists[j-1] = lists[j];
			}
			(*nlists)--;
		}
	}
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "unique-array", argc, argv,
		1, 100000, "array of ints" );

	int numarrays = argc-argno;
	if( debug )
	{
		printf( "debug: numarrays=%d\n", numarrays );
	}
	sizedarray *alllists = malloc( numarrays * sizeof(sizedarray) );
	assert( alllists );

	int i;
	for( i=argno; i<argc; i++ )
	{
		int nel;
		int *l = parse_int_arg( argv[i], &nel );
		alllists[i-argno].nel = nel;
		alllists[i-argno].list = l;
	}
	assert( i==argc );

	remove_duplicate_arrays( alllists, &numarrays );

	for( int i=0; i<numarrays; i++ )
	{
		int nel = alllists[i].nel;
		int *l = alllists[i].list;
		print_int_array( 80, nel, l, ',', stdout );
		putchar( '\n' );
	}

	for( int i=0; i<numarrays; i++ )
	{
		free( alllists[i].list );
	}
	free( alllists );

	return 0;
}
