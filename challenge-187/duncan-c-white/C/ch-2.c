//
// Task 2: Magical Triplets
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
	int a, b, c;
	int sum;	// computed field: a+b+c
} triplet;


typedef struct		// a dynamic list of triplets
{
	int n, max;
	int maxsum;
	triplet *t;	// dynarray t[max] allocated, t[0..n-1] in use
} tlist;


// tlist t;
// bool alreadyseen = add_tlist( a, b, c, &t );
//	Add the triple (a,b,c) to tlist t unless it's already
//	present.  Return true if it was already present, else return false.
bool add_tlist( int a, int b, int c, tlist *t )
{
	for( int i=0; i<t->n; i++ )
	{
		triplet *p = &(t->t[i]);
		if( p->a == a && p->b == b && p->c == c )
		{
			return true;
		}
	}
	// not found, add (a,b,c) to t
	if( t->n == t->max )
	{
		t->max += 100;
		t->t = realloc( t->t, t->max );
		assert( t->t != NULL );
	}
	triplet *p = &(t->t[t->n++]);
	p->a = a;
	p->b = b;
	p->c = c;
	// keep track of triplet sum, and tlist maxsum so far
	p->sum = a+b+c;
	if( p->sum > t->maxsum )
	{
		t->maxsum = p->sum;
	}
	return false;
}


// showtlist( FILE *out, char *name, tlist *t );
//	Display t on out.
void showtlist( FILE *out, char *name, tlist *t )
{
	fprintf( out, "%s has %d triples, max sum=%d\n",
		name, t->n, t->maxsum );
	for( int i=0; i<t->n; i++ )
	{
		triplet *p = &(t->t[i]);
		fprintf( out, "%d+%d+%d=%d\n", p->a, p->b, p->c, p->sum );
	}
}


// freetlist( t );
//	Free the tlist t.
void freetlist( tlist *t )
{
	free( t->t );
	free( t );
}


// tlist *t = pass1( x, nel );
//	generate all triples of 3 distinct elements in x (in
//	any order) and find those triples that pass rules 1..3,
//	building and returning a tlist t of the triplets found.
//	Note that a tlist keeps track of the triplet sums, and
//	even the current maximum sum, so it's more like pass1+2
//	of the original Perl code.
//	Note that the returned value t must be freed by the caller after use.
//
tlist *pass1( int *x, int nel )
{
	tlist *result = malloc( sizeof(tlist) );
	assert( result != NULL );
	result->max = 100;
	result->n = 0;
	result->maxsum = 0;
	result->t = malloc( result->max * sizeof(triplet) );
	assert( result->t != NULL );

	for( int p1=0; p1<nel; p1++ )
	{
		for( int p2=0; p2<nel; p2++ )
		{
			if( p1==p2 ) continue;
			for( int p3=0; p3<nel; p3++ )
			{
				if( p1==p3 || p2==p3 ) continue;
				int a = x[p1];
				int b = x[p2];
				int c = x[p3];
				if( a+b<=c || b+c<=a || a+c<=b ) continue;
				if( add_tlist( a, b, c, result ) ) continue;
				if( debug )
				{
					printf( "debug: semi-magic triple %d, %d, %d, sum=%d\n", a, b, c, a+b+c );
					//showtlist( stdout, "s-m-ts", result );
				}
			}
		}
	}

	return result;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "magic-triple", argc, argv,
		1, "csvlist" );

	if( debug )
	{
		printf( "debug: argno=%d, firstarg=%s\n", argno, argv[argno] );
	}

	int nel;
	int *x = parse_int_args( argc, argv, argno, &nel );
	nel--;

	if( nel<3 )
	{
		fprintf( stderr, "magic-triple: csvlist %s must contain at least 3 numbers\n", argv[argno] );
		exit(1);
	}

	if( debug )
	{
		printf( "nel=%d, x=", nel );
		print_int_array( 70, nel, x, ',', stdout );
		putchar( '\n' );
	}

	// pass 1 - generate all triples of 3 distinct elements in x (in
	//	    any order) and find those triples that pass rules 1..3
	tlist *p1t = pass1( x, nel );
	showtlist( stdout, "pass1 triples", p1t );

	// if there are NO triplets found obeying rules 1..3, report failure
	if( p1t->n == 0 )
	{
		printf( "No magic triplets found\n" );
		exit(0);
	}

	// pass2: identify which of those triples has the maxsum && has a>=b>=c
	for( int i=0; i<p1t->n; i++ )
	{
		triplet *p = &(p1t->t[i]);
		if( p->sum != p1t->maxsum ) continue;
		if( p->a < p->b || p->b < p->c ) continue;
		printf( "Found magic triple %d, %d, %d\n", p->a, p->b, p->c );
	}

	freetlist( p1t );

	free( x );
	return 0;
}
