//
// Task 1: Minimum Index Sum
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
#include "csvsplit.h"


typedef struct
{
	char **arr;	// array of 256 char *s
	int nel;
} strlist;


void process1( char *str, void *extra )
{
	strlist *e = (strlist *)extra;
	char *s = strdup( str );
	assert( s != NULL );
	e->arr[ e->nel++ ] = s;
}


void print_strlist( strlist *list )
{
	bool first = true;
	for( int i=0; i<list->nel; i++ )
	{
		if( ! first ) putchar( ',' );
		fputs( list->arr[i], stdout );
		first = false;
	}
}


// bool isin = in_strlist( word, &list );
bool in_strlist( char *word, strlist *list )
{
	for( int i=0; i<list->nel; i++ )
	{
		if( strcmp( word, list->arr[i] ) == 0 )
		{
			return true;
		}
	}
	return false;
}


// int sum = indexsum( word, &list1, &list2 );
//	Calculate and return the index sum of word in the two lists.
int indexsum( char *word, strlist *list1, strlist *list2 )
{
	int sum = 0;
	for( int pos=0; pos < list1->nel; pos++ )
	{
		if( strcmp( list1->arr[pos], word ) == 0 )
		{
			sum += pos;
		}
	}
	for( int pos=0; pos < list2->nel; pos++ )
	{
		if( strcmp( list2->arr[pos], word ) == 0 )
		{
			sum += pos;
		}
	}
	return sum;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "mis", argc, argv,
		2, "wordlist wordlist" );

	strlist list1;
	list1.arr = malloc( 256*sizeof(char *) );
	assert( list1.arr != NULL );
	list1.nel = 0;
	csvForeach( argv[argno++], &process1, &list1 );

	strlist list2;
	list2.arr = malloc( 256*sizeof(char *) );
	assert( list2.arr != NULL );
	list2.nel = 0;
	csvForeach( argv[argno], &process1, &list2 );

	if( debug )
	{
		printf( "list1: " );
		print_strlist( &list1 );
		putchar( '\n' );
		printf( "list2: " );
		print_strlist( &list2 );
		putchar( '\n' );
	}

	strlist common;
	common.arr = malloc( 256*sizeof(char *) );
	assert( common.arr != NULL );
	common.nel = 0;

	for( int i=0; i<list1.nel; i++ )
	{
		// look for list1.arr[i] in list2
		if( in_strlist( list1.arr[i], &list2 ) )
		{
			common.arr[common.nel++] = list1.arr[i];
		}
	}
	if( debug )
	{
		printf( "There are %d common strings: ", common.nel );
		print_strlist( &common );
		putchar( '\n' );
	}

	int mis = list1.nel + list2.nel;
	strlist best;
	best.arr = malloc( 256*sizeof(char *) );
	assert( best.arr != NULL );
	best.nel = 0;

	for( int pos=0; pos<common.nel; pos++ )
	{
		char *w = common.arr[pos];
		int s = indexsum( w, &list1, &list2 );
		if( debug )
		{
			printf( "The index sum of %s is %d\n", w, s );
		}
		if( s < mis )
		{
			mis = s;
			best.arr[0] = w;
			best.nel = 1;
		} else if( s == mis )
		{
			best.arr[best.nel++] = w;
		}
	}

	putchar( '(' );
	print_strlist( &best );
	putchar( ')' );
	putchar( '\n' );

	for( int i=0; i<list1.nel; i++ )
	{
		free( list1.arr[i] );
	}
	free( list1.arr );
	for( int i=0; i<list2.nel; i++ )
	{
		free( list2.arr[i] );
	}
	free( list2.arr );

	free( common.arr );

	free( best.arr );

	return 0;
}
