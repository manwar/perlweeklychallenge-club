// Simple routines to parse one (or one or more) arguments,
// looking for individual +ints or comma-separated
// lists of +ints.
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
		assert( p->list );
	}
	if( debug )
	{
		printf( "PIA: appending %d to result at "
			"pos %d\n", x, p->nel );
	}
	p->list[p->nel++] = x;
}


//
// intlist il.. then initialize il..  then:
// add_one_arg( argstr, &il );
//	
static void add_one_arg( char *argstr, intlist *p )
{
	int x;
	if( !check_unsigned_int(argstr,&x) )
	{
		fprintf( stderr, "PIA: arg %s must be +int\n", argstr );
		exit(1);
	}
	add_one( x, p );
}


//
// int nel;
// int *ilist = parse_int_arg( argstr, &nel );
//	process argstr, extracting either a single int or a
//	comma-separated lists of ints from it,
//	accumulate all integers in a dynarray list, storing the total number
//	of elements in nel.  This list must be freed by the caller.
int *parse_int_arg( char *argstr, int *nel )
{
	int *result = malloc( 128 * sizeof(int) );
	assert( result );
	intlist il = { 0, 128, result };

	if( debug )
	{
		printf( "PIA: parsing ints from arg %s\n", argstr );
	}

	assert( strlen(argstr) < 1024 );
	char copy[1024];
	strcpy( copy, argstr );
	char *com;
	char *s;
	for( s=copy; (com = strchr(s,',')) != NULL; s=com+1 )
	{
		*com = '\0';
		add_one_arg( s, &il );
	}
	add_one_arg( s, &il );

	if( debug )
	{
		printf( "PIA: final list is " );
		print_int_array( 80, il.nel, il.list, ',', stdout );
		putchar( '\n' );
	}

	*nel = il.nel;
	return il.list;
}


//
// int nel;
// int *ilist = parse_int_args( argc, argv, argno, &nel );
//	process all arguments argv[argno..argc-1], extracting either
//	single ints or comma-separated lists of ints from those arguments,
//	accumulate all integers into a single dynarray list, storing the total
//	number of elements in nel.  This list must be freed by the caller.
int *parse_int_args( int argc, char **argv, int argno, int *nel )
{
	int *result = malloc( 128 * sizeof(int) );
	assert( result );
	intlist il = { 0, 128, result };

	if( debug )
	{
		printf( "PIA: parsing ints from args %d..%d\n", argno, argc-1 );
	}
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

	add_one( -1, &il );

	if( debug )
	{
		printf( "PIA: final list is " );
		print_int_array( 80, il.nel, il.list, ',', stdout );
	}

	*nel = il.nel;
	return il.list;
}
