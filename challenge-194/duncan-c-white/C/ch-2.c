//
// Task 2: Frequency Equalizer
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


static int compn(const void *p1, const void *p2)
{
   // The actual arguments to this function are "pointers to ints"
   return (*(int *) p1) - (*(int *) p2);
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "odd-strings", argc, argv,
		1, "string" );

	if( debug )
	{
		printf( "debug: argno=%d, argc=%d\n", argno, argc );
	}

	char *str = argv[argno];

	if( debug )
	{
		printf( "debug: str=%s\n", str );
	}

	// build a freq mapping
	int freq[256];
	for( int i=0; i<256; i++ )
	{
		freq[i] = 0;
	}
	for( char *s=str; *s; s++ )
	{
		freq[(int)*s]++;
	}

	// sort the frequencies
	qsort( freq, 256, sizeof(int), &compn );

	if( debug )
	{
		printf( "after sorting: " );
		for( int i=0; i<256; i++ )
		{
			if( freq[i] != 0 ) printf( "%d: %d,", i, freq[i] );
		}
		putchar('\n');
	}

	// skip over any zeros
	int firstnq=0;
	for( ; firstnq<256 && freq[firstnq]==0; firstnq++ ) /*EMPTY BODY*/;

	int result = (freq[255] == 1 + freq[254] && freq[firstnq] == freq[254]) ? 1 : 0;
	printf( "%d\n", result );

	return 0;
}
