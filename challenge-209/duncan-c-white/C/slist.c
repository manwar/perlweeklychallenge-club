// slist.c:	a sorted list of strings, to be used like a set to which items
// are ever added

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>

#include "csvsplit.h"
#include "slist.h"


// A sorted list is a growable dynarray of string pointers into a common
// string buffer (storage for which is also maintained inside the slist).


// slist s = make_slist( cap, bufcap );
//	Create an empty sorted list with capacity >= cap
//	and the initial buffer capacity bufcap
//
slist make_slist( int cap, int bufcap )
{
	slist s = malloc( sizeof(struct slist) );
	assert( s != NULL );
	s->cap  = cap + 10;
	s->n    = 0;
	s->data = malloc( s->cap * sizeof(char *) );
	assert( s->data != NULL );
	s->bufcap = bufcap + 100;
	s->buflen = 0;
	s->buf = malloc( s->bufcap * sizeof(char) );
	assert( s->buf != NULL );
	return s;
}


static int cmpstringp( const void *p1, const void *p2 )
{
	// The actual arguments to this function are "pointers to
	// pointers to char", but strcmp(3) arguments are "pointers
	// to char", hence the following cast plus dereference
	return strcmp( *(const char **) p1, *(const char **) p2 );
}


// void append_slist( s, item );
//	Append a given item to sorted list s, growing it if necessary
//
void append_slist( slist s, char *item )
{
	int len = strlen(item)+1;
	if( s->buflen + len > s->bufcap )
	{
		s->bufcap += 100 + len;
		s->buf = realloc( s->buf, s->bufcap * sizeof(char) );
		assert( s->buf != NULL );
	}
	char *sp = s->buf + s->buflen;
	strcpy( sp, item );
	s->buflen += len;

	if( s->n == s->cap )
	{
		s->cap += 100;
		s->data = realloc( s->data, s->cap * sizeof(char *) );
		assert( s->data != NULL );
	}
	s->data[s->n++] = sp;

	// re-sort data
	qsort( s->data, s->n, sizeof(char *), &cmpstringp );

	#if 0
	printf( "debug: after appending %s, slist is ", item );
	print_slist( s, stdout ); putchar( '\n' );
	#endif
}


// bool isin = isin_slist( value, s );
//	Given a sorted list s return true iff value is "in" s.
//	Could use bsearch() if we cared enough..
//
bool isin_slist( char *value, slist s )
{
	for( int i=0; i<s->n; i++ )
	{
		if( strcmp( value, s->data[i] ) == 0 ) return true;
	}
	return false;
}


// bool any = overlap_slists( s1, s2 );
//	Given two sorted lists (s1 and s2) return true
//	iff the two lists contain any common members, even one.
//
bool overlap_slists( slist s1, slist s2 )
{
	for( int i=0; i<s1->n; i++ )
	{
		if( isin_slist( s1->data[i], s2 ) ) return true;
	}
	return false;
}


// union_slists( s1, s2 );
//	Given two sorted lists (s1 and s2) do a set union operation
//	altering s1.
//
void union_slists( slist s1, slist s2 )
{
	for( int i=0; i<s2->n; i++ )
	{
		if( ! isin_slist( s2->data[i], s1 ) )
		{
			append_slist( s1, s2->data[i] );
		}
	}
}


// print_slist( s, out );
//	Print sorted list s to open writable file out
//	as a CSV list.
//
void print_slist( slist s, FILE *out )
{
	for( int i=0; i<s->n; i++ )
	{
		if( i>0 ) putc( ',', out );
		printf( "%s", s->data[i] );
	}
}


// free_slist( s );
//	Free sorted list s
//
void free_slist( slist s )
{
	free( s->data );
	free( s->buf );
	free( s );
}
