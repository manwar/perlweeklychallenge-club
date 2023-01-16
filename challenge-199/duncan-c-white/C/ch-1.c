//
// Task 1: Good Pairs
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
	p->npairs++;
	if( p->npairs == p->nalloc )
	{
		p->nalloc += 10;
		p->p = realloc( p->p, p->nalloc * sizeof(pair) );
		assert( p->p != NULL );
	}
	p->p[p->npairs].i = i;
	p->p[p->npairs].j = j;
}


void free_pairdynarray( pairdynarray *p )
{
	if( p->p != NULL ) free( p->p );
	p->p = NULL;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "good-pairs", argc, argv,
		1, 1000, "intlist" );

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( nel < 1 )
	{
		fprintf( stderr, "good-pairs: need a list of > 0 elements\n" );
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

	for( int i=0; i<nel; i++ )
	{
		for( int j=i+1; j<nel; j++ )
		{
			if( list[i] != list[j] ) continue;

			add_pair( &p, i, j );
		}
	}

	if( debug )
	{
		printf( "debug: npairs=%d, nalloc=%d\n", p.npairs, p.nalloc );
	} else
	{
		printf( "%d\n", p.npairs );
	}

	printf( "Good pairs are below:\n" );
	for( int n=0; n<p.npairs; n++ )
	{
		printf( "(%d,%d)\n", p.p[n].i, p.p[n].j );
	}

	free( list );
	free_pairdynarray( &p );

	return 0;
}
