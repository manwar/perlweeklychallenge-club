#include <stdio.h>
#include <string.h>


#include "rank.h"


// print_rank_array( maxw, nelements, results[], sep, outfile );
//	format results[0..nelements-1] as a <sep> separated
//      list onto outfile with lines <= maxw chars long.
//	Replace 1 with G, 2 with S, and 3 with B.
//	produces a whole number of lines of output.
//
void print_rank_array( int maxw, int nel, int *results, char sep, FILE *out )
{
	int linelen = 0;
	for( int i=0; i<nel; i++ )
	{
		char buf[100];
		sprintf( buf, "%d", results[i] );
		switch( results[i] )
		{
		case 1: strcpy( buf, "G" ); break;
		case 2: strcpy( buf, "S" ); break;
		case 3: strcpy( buf, "B" ); break;
		}
		int len = strlen(buf);
		if( linelen + len + 2 > maxw )
		{
			fputc( '\n', out );
			linelen = 0;
		//} else if( i>0 )
		//{
		//	fputc( ' ', out );
		//	linelen++;
		}

		linelen += len;
		fprintf( out, "%s", buf );
		if( i<nel-1 )
		{
			fputc( sep, out );
			linelen++;
		}
	}
}
