//
// Task 2: Good Triplets
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
	int i, j, k;
} triple;


typedef struct {
	int ntriples;	// number of triples.
	int nalloc;	// number of triples allocated (nalloc >= ntriples)
	triple *p;	// block to store up to <nalloc> triples, of which
			// the first <ntriples> are in use at present.
} tripledynarray;


void init_tripledynarray( tripledynarray *t )
{
	t->ntriples = 0;
	t->nalloc = 10;
	t->p = malloc( t->nalloc * sizeof(triple) );
	assert( t->p != NULL );
}


void add_triple( tripledynarray *t, int i, int j, int k )
{
	t->p[t->ntriples].i = i;
	t->p[t->ntriples].j = j;
	t->p[t->ntriples].k = k;
	t->ntriples++;
	if( t->ntriples == t->nalloc )
	{
		t->nalloc += 10;
		t->p = realloc( t->p, t->nalloc * sizeof(triple) );
		assert( t->p != NULL );
	}
}


void free_tripledynarray( tripledynarray *t )
{
	if( t->p != NULL ) free( t->p );
	t->p = NULL;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "good-triples", argc, argv,
		4, 1000, "intlist" );

	int x = atoi( argv[argno++] );
	int y = atoi( argv[argno++] );
	int z = atoi( argv[argno++] );

	if( debug )
	{
		printf( "debug: x=%d, y=%d, z=%d\n", x, y, z );
	}

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( nel < 3 )
	{
		fprintf( stderr, "good-triples: need a list of > 2 elements\n" );
		exit(1);
	}

	if( debug )
	{
		printf( "debug: initial list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	tripledynarray t;
	init_tripledynarray( &t );

	for( int i=0; i<nel; i++ )
	{
		for( int j=i+1; j<nel; j++ )
		{
			if( abs(list[i]-list[j]) > x ) continue;

			for( int k=j+1; k<nel; k++ )
			{
				if( abs(list[j]-list[k]) <= y &&
				    abs(list[i]-list[k]) <= z )
				{
				  add_triple( &t, list[i], list[j], list[k] );
				}
			}
		}
	}

	if( debug )
	{
		printf( "debug: ntriples=%d, nalloc=%d\n", t.ntriples, t.nalloc );
	} else
	{
		printf( "%d\n", t.ntriples );
	}

	if( t.ntriples > 0 )
	{
		printf( "Good triples are below:\n" );
		for( int n=0; n<t.ntriples; n++ )
		{
			printf( "(%d,%d,%d)\n", t.p[n].i, t.p[n].j, t.p[n].k );
		}
	}

	free( list );
	free_tripledynarray( &t );

	return 0;
}
