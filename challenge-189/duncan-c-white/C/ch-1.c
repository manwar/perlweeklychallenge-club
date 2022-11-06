//
// Task 1: Greater Character
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


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "gt-chr", argc, argv,
		2, "target string" );

	char *tstr = argv[argno++];
	char target = *tstr;
	char *str = argv[argno++];

	if( debug )
	{
		printf( "debug: target=%c, str=%s\n", target, str );
	}

	char minchar = 127;
	int len = strlen(str);
	for( int i=0; i<len; i++ )
	{
		char ch = str[i];
		if( debug )
		{
			printf( "debug: str[%d] = '%c' minsofar='%c'\n",
				i, ch, minchar );
		}
		if( ch > target && ch < minchar )
		{
			minchar = ch;
		}
	}
	if( minchar == 127 ) minchar = target;
	printf( "%c\n", minchar );

	return 0;
}
