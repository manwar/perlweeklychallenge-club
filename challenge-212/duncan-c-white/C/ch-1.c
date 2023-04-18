// Task 1: Jumping Letters
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


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "jumping-letters", argc, argv,
		2, 1000, "word intlist" );
	char *word = argv[argno++];
	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( debug )
	{
		printf( "debug: word = %s, list: ", word );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	int len = strlen(word);

	if( len != nel )
	{
		fprintf( stderr, "jumping-letters: word (len %d) must be "
			 "same length as list (len %d)\n", len, nel );
		exit(1);
	}

	for( int pos=0; pos < len; pos++ )
	{
		char letter = word[pos];
		int offset = list[pos];
		if( debug )
		{
			printf( "debug: pos: %d, letter: %c, offset: %d\n",
				pos, letter, offset );
		}
		int base = 0;
		if( islower(letter) )
		{
			base = 'a';
		} else if( isupper(letter) )
		{
			base = 'A';
		} else
		{
			continue;
		}
		int lpos = letter-base;
		offset = (offset + lpos) % 26;
		if( debug )
		{
			printf( "debug: letter=%c, base=%c, lpos=%d, "
				"offset=%d\n", letter, base, lpos, offset );
		}
		letter = offset+base;
		word[pos] = letter;
		if( debug )
		{
			printf( "debug: newletter=%c\n", letter );
		}
	}

	printf( "%s\n", word );
	free( list );
	return 0;
}
