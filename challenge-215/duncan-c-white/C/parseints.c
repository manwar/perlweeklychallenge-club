// Simple routine to parse one or more arguments,
// looking for individual ints or comma-separated
// lists of ints.
// 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>

#include "args.h"
#include "printarray.h"
#include "parseints.h"

typedef struct
{
	int nel;	// current number of elements 
	int maxel;	// maximum number of elements allocated
	int *list;	// malloc()d list of integers
} intlist;


//
// intlist il.. then initialize il..  then:
// add_one( element, &il );
//	
static void add_one( int x, intlist *p )
{
	if( p->nel > p->maxel )
	{
		p->maxel += 128;
		p->list = realloc( p->list, p->maxel );
		assert( p->list != NULL );
	}
	#if 0
	if( debug )
	{
		printf( "PIA: appending %d to result at "
			"pos %d\n", x, p->nel );
	}
	#endif
	p->list[p->nel++] = x;
}


//
// intlist il.. then initialize il..  then:
// add_one_arg( argstr, &il );
//	
static void add_one_arg( char *argstr, intlist *p )
{
	int x;
	if( !check_int(argstr,&x) )
	{
		fprintf( stderr, "PIA: arg %s must be int\n", argstr );
		exit(1);
	}
	add_one( x, p );
}


//
// int nel;
// int *ilist = parse_int_args( argc, argv, argno, &nel );
//	process all arguments argv[argno..argc-1], extracting either
//	single ints or comma-separated lists of ints from those arguments,
//	accumulate all integers in a dynarray list, storing the total number
//	of elements in nel.  This list must be freed by the caller.
//	Note that the list of elements used to be terminated by a -1 value,
//	but I've commented this out from now on.
//
int *parse_int_args( int argc, char **argv, int argno, int *nel )
{
	int *result = malloc( 128 * sizeof(int) );
	assert( result != NULL );
	intlist il = { 0, 128, result };

	#if 0
	if( debug )
	{
		printf( "PIA: parsing ints from args %d..%d\n", argno, argc-1 );
	}
	#endif
	for( int i=argno; i<argc; i++ )
	{
		assert( strlen(argv[i]) < 1024 );
		char copy[1024];
		strcpy( copy, argv[i] );
		char *com;
		char *s;
		for( s=copy; (com = strchr(s,',')) != NULL; s=com+1 )
		{
			*com = '\0';
			add_one_arg( s, &il );
		}
		add_one_arg( s, &il );
	}

	//add_one( -1, &il );

	#if 0
	if( debug )
	{
		printf( "PIA: final list is " );
		print_int_array( 80, il.nel, il.list, ',', stdout );
		putchar( '\n' );
	}
	#endif

	*nel = il.nel;
	return il.list;
}
