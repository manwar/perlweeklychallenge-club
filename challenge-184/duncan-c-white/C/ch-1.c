//
// Task 1: Sequence Number
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


//
// seqno( strbuf );
//	Given a writable string in the format aa9999 i.e. first 2 characters
//	can be anything 'a-z' followed by 4 digits '0-9', 
//	replace the first two characters with sequence starting
//	with '00', '01', '02' etc.
//
static void seqno( char *strbuf )
{
	static int seqno = 0;
	if( strlen(strbuf)!=6 || !isalpha(strbuf[0]) || !isalpha(strbuf[1])
	||  !isdigit(strbuf[2]) || !isdigit(strbuf[3]) || ! isdigit(strbuf[4])
	||  !isdigit(strbuf[5]) )
	{
		fprintf( stderr, "bad format %s: not lldddd\n", strbuf );
		exit(1);
	}
	int x = seqno++;
	strbuf[0] = '0' + x/10;
	strbuf[1] = '0' + x%10;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "sequence-number", argc, argv,
		1, 100000, "list of strings" );

	int numarrays = argc-argno;
	if( debug )
	{
		printf( "debug: numarrays=%d\n", numarrays );
	}

	int i;
	bool isfirst=true;
	for( i=argno; i<argc; i++ )
	{
		if( !isfirst )
		{
			putchar(',');
		}
		isfirst=false;
		char arg[10];
		strcpy( arg, argv[i] );
		seqno( arg );
		printf( "%s", arg );
	}
	putchar('\n');

	return 0;
}
