//
// Task 1: Arithmetic Slices
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


typedef struct {
	int i, j;
} pair;


typedef struct {
	int npairs;	// number of pairs.
	int nalloc;	// number of pairs allocated (nalloc >= npairs)
	pair *p;	// block to store up to <nalloc> pairs, of which
			// the first <npairs> are in use at present.
} pairdynarray;


void init_pairdynarray( pairdynarray *p )
{
	p->npairs = 0;
	p->nalloc = 10;
	p->p = malloc( p->nalloc * sizeof(pair) );
	assert( p->p != NULL );
}


void add_pair( pairdynarray *p, int i, int j )
{
	if( debug )
	{
		printf( "debug: adding pair %d..%d\n", i, j );
	}
	p->p[p->npairs].i = i;
	p->p[p->npairs].j = j;
	p->npairs++;
	if( p->npairs == p->nalloc )
	{
		p->nalloc += 10;
		p->p = realloc( p->p, p->nalloc * sizeof(pair) );
		assert( p->p != NULL );
	}
}


void free_pairdynarray( pairdynarray *p )
{
	if( p->p != NULL ) free( p->p );
	p->p = NULL;
}


bool isarith( int *list, int from, int to )
{
	int v = list[from];
	for( int i=from+1; i<=to; i++ )
	{
		v++;
		if( list[i] != v ) return false;
	}
	return true;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "arithmetic-slices", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( nel < 3 )
	{
		fprintf( stderr, "arithmetic-slices: need a list of > 2 elements\n" );
		exit(1);
	}

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	pairdynarray p;
	init_pairdynarray( &p );

	for( int i=0; i<nel-2; i++ )
	{
		for( int j=i+2; j<nel; j++ )
		{
			if( isarith( list, i, j ) )
			{
				add_pair( &p, i, j );
			}
		}
	}

	if( debug )
	{
		printf( "debug: npairs=%d, nalloc=%d\n", p.npairs, p.nalloc );
	}

	printf( "Results:\n" );
	for( int n=0; n<p.npairs; n++ )
	{
		int from = p.p[n].i;
		int to = p.p[n].j;
		if( debug )
		{
			printf( "debug: from=%d, to=%d\n", from, to );
		}
		printf( "(" );
		for( int i=from; i<=to; i++ )
		{
			if( i>from ) putchar( ',' );
			printf( "%d", list[i] );
		}
		printf( ")\n" );
	}

	free( list );
	free_pairdynarray( &p );

	return 0;
}
