// Task 1: Odd one Out
//
// C translation

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>

#include "args.h"
#include "parseints.h"
#include "printarray.h"


//
// bool issorted = sortedletters( word );
//	Return true iff the letters of word are sorted.
//
bool sortedletters( char *word )
{
	int len = strlen(word);
	for( int pos=0; pos<len-1; pos++ )
	{
		if( word[pos] > word[pos+1] ) return false;
	}
	return true;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "odd-one-out", argc, argv,
		1, 1000, "wordlist" );

	if( debug )
	{
		printf( "debug: list: " );
		for( int i=argno; i<argc; i++ )
		{
			if( i>argno ) putchar( ',' );
			printf( "%s", argv[i] );
		}
		putchar( '\n' );
	}

	char *sorted[argc];
	int nsorted = 0;
	char *nonsorted[argc];
	int nnonsorted = 0;
	for( int i=argno; i<argc; i++ )
	{
		if( sortedletters( argv[i] ) )
		{
			sorted[nsorted++] = argv[i];
		} else
		{
			nonsorted[nnonsorted++] = argv[i];
		}
	}


	printf( "%d\n", nnonsorted );
	if( debug )
	{
		printf( "list (of sorted) words is: " );
		for( int i=0; i<nsorted; i++ )
		{
			if( i>0 ) putchar(',');
			printf( "%s", sorted[i] );
		}
		putchar( '\n' );
		printf( "unsorted words removed are: " );
		for( int i=0; i<nnonsorted; i++ )
		{
			if( i>0 ) putchar(',');
			printf( "%s", nonsorted[i] );
		}
		putchar( '\n' );
	}

	return 0;
}
