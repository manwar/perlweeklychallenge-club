//
// Task 2: Shortest Route
// 
// C version.
// 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>
#include <math.h>

#include "args.h"
#include "parseints.h"
#include "printarray.h"


typedef struct
{
	int nroute;		// number of routes
	int **route;		// dynarray route[nroute] of int *
	int *routelen;		// dynarray routelen[nroute]
	int ndistinctnodes;	// number of distinct nodes
	int end;		// the desired target (end) of the route
} graph;


// int nch = countch( target, str );
//      Count and return the number of occurrences of target in str.
//
int countch( char target, char *str )
{
        int n=0;
        for( ; *str; str++ )
        {
                if( *str == target ) n++;
        }
        return n;
}


//
// bool in = isin( v, list, nel );
//	Return true iff v is in list[nel].
//
bool isin( int v, int *list, int nel )
{
	for( int i=0; i<nel; i++ )
	{
		if( list[i] == v ) return true;
	}
	return false;
}


// count_distinct_nodes( g );
//	Count how many distinct nodes there are in g->route[g->nroute]
//	where each g->route[i] is of length g->routelen[i], fill in
//	g->ndistinctnodes
//
void count_distinct_nodes( graph *g )
{
	// dynarray of seen nodes, grown as needed
	int maxseen = 10;
	int *seen = malloc( maxseen * sizeof(int) );
	assert( seen != NULL );
	int nseen = 0;

	int nnodes = 0;

	for( int i=0; i<g->nroute; i++ )
	{
		for( int j=0; j<g->routelen[i]; j++ )
		{
			int node = g->route[i][j];
			if( debug )
			{
				printf( "debug: route %d, pos %d, node %d\n",
					i, j, node );
			}
			if( ! isin( node, seen, nseen ) )
			{
				if( nseen == maxseen )
				{
					maxseen += 10;
					seen = realloc( seen,
						maxseen * sizeof(int) );
					assert( seen != NULL );
				}
				seen[nseen++] = node;
				nnodes++;
			}
		}
	}

	free( seen );
	g->ndistinctnodes = nnodes;
}


// int nnext = next_nodes( here, g, visited, nvis, nextnodes );
//	Given the graph g, determine all the possible one-step-next-nodes
//	from here that are not in visited[nvis], store those nodes into
//	nextnodes[] and return the number of next nodes.
//
int next_nodes( int here, graph *g, int *vis, int nvis, int *nextnodes )
{
	int nn = 0;

	for( int i=0; i<g->nroute; i++ )
	{
		int prev = g->route[i][0];
		for( int j=1; j<g->routelen[i]; j++ )
		{
			int node = g->route[i][j];
			// prev->node link and node->prev link
			if( here==prev && ! isin( node, vis, nvis ))
			{
				nextnodes[nn++] = node;
			} else if( here==node && ! isin( prev, vis, nvis ))
			{
				nextnodes[nn++] = prev;
			}
			prev = node;
		}
	}
	if( debug )
	{
		printf( "debug: %d nextnodes from %d: ", nn, here );
		print_int_array( 60, nn, nextnodes, ',', stdout );
		putchar( '\n' );
	}
	return nn;
}


static int *sr;		// sr[ndistinctnodes] - curr shortest route
static int srnel; 	// current number of elements in shortest route
static int srlen; 	// current length of shortest route for comparison


//
// all_routes( start, g, done, ndone );
//	Find all routes from start thru graph g to g->end,
//	where we have already visted done[ndone], setting sr[srlen]
//	to the shortest route found.
//
static void all_routes( int start, graph *g, int *done, int ndone )
{
	if( start == g->end )
	{
		// found route done + end
		done[ ndone++ ] = g->end;
		if( debug )
		{
			printf( "debug: found new route " );
			print_int_array( 60, ndone, done, ',', stdout );
			putchar( '\n' );
		}
		if( ndone < srlen )
		{
			for( int i=ndone; i<srlen; i++ ) sr[i] = 0;
			for( int i=0; i<ndone; i++ ) sr[i] = done[i];
			srlen = ndone;
			srnel = ndone;
			if( debug )
			{
				printf( "debug: found new shortest route " );
				print_int_array( 60, srnel, sr, ',', stdout );
				putchar( '\n' );
			}
		}
	}
	if( debug )
	{
		printf( "debug: done=" );
		print_int_array( 60, ndone, done, ',', stdout );
		putchar( '\n' );
	}
	int nextnodes[g->ndistinctnodes];
	int nnext = next_nodes( start, g, done, ndone, nextnodes );
	if( debug )
	{
		printf( "start=%d, end=%d, next=", start, g->end );
		print_int_array( 60, nnext, nextnodes, ',', stdout );
		putchar( '\n' );
	}

	//int newdone[g->ndistinctnodes];
	//memcpy( newdone, done, ndone * sizeof(int) );
	//int nnewdone = ndone;
	//newdone[ nnewdone++ ] = start;
	done[ ndone++ ] = start;
	for( int i=0; i<nnext; i++ )
	{
		//all_routes( nextnodes[i], g, newdone, nnewdone );
		all_routes( nextnodes[i], g, done, ndone );
	}
}


//
// int nshortest = shortest_route( start, end, g, shortest );
//	Find the shortest route from start to end in the graph
//	store it into shortest[nshortest] and return nshortest.
//
static int shortest_route( int start, int end, graph *g, int *shortest )
{
	sr = shortest;
	srnel = 0;
	srlen = g->ndistinctnodes + 1;
	int done[srlen];
	g->end = end;
	all_routes( start, g, done, 0 );
	return srnel;
}


// args2graph( argc, argno, argv, &g );
//	Process argv[argno..argc-1] as routes, building graph g.
//
static void args2graph( int argc, int argno, char **argv, graph *g )
{
	g->nroute = argc-argno;
	g->route = malloc( g->nroute * sizeof(int *) );
	assert( g->route != NULL );
	g->routelen = malloc( g->nroute * sizeof(int) );
	assert( g->routelen != NULL );

	for( int i=0; i<g->nroute; i++ )
	{
		char *s = argv[argno++];
		int ncomma = countch( ',', s );
		g->routelen[i] = ncomma+1;
		g->route[i] = malloc( g->routelen[i] * sizeof(int) );
		assert( g->route[i] != NULL );
		int r = 0;
		for(;;)
		{
			g->route[i][r++] = atoi(s);
			char *p = strchr(s,',');
		if( p == NULL ) break;
			s = p+1;
		}
		assert( r == g->routelen[i] );
	}

	count_distinct_nodes( g );
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "shortest-route", argc, argv,
		3, 1000, "start end list(intlist)" );
	int start = atoi(argv[argno++]);
	int end = atoi(argv[argno++]);

	graph g;
	args2graph( argc, argno, argv, &g );

	if( debug )
	{
		printf( "debug: start=%d, end=%d, %d distinct nodes, routes:\n",
			start, end, g.ndistinctnodes );
		for( int i=0; i<g.nroute; i++ )
		{
			print_int_array( 60, g.routelen[i], g.route[i],
					 ',', stdout );
			putchar( '\n' );
		}
	}

	#ifdef TESTNEXTNODES
	int *nextnodes = malloc( g.ndistinctnodes * sizeof(int) );
	assert( nextnodes != NULL );

	// debugging block
	#if 0
	int visited[10];
	int nvis = 0;

	visited[nvis++] = 2;
	visited[nvis++] = 5;
	int nnext = next_nodes( start, &g, visited, nvis, nextnodes );
	print_int_array( 60, nvis, visited, ',', stdout );
	putchar( '\n' );
	#endif

	free( nextnodes );
	#endif

	int shortest[g.ndistinctnodes];
	int nshortest = shortest_route( start, end, &g, shortest );
	printf( "shortest path is " );
	if( nshortest == 0 )
	{
		printf( "-1\n" );
	} else
	{
		print_int_array( 60, nshortest, shortest, ',', stdout );
		putchar( '\n' );
	}

	free( g.routelen );
	for( int i=0; i<g.nroute; i++ )
	{
		free( g.route[i] );
	}
	free( g.route );

	return 0;
}
