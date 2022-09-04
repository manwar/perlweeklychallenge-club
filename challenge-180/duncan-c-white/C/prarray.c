#include <stdio.h>
#include <string.h>


// print_int_array( maxw, nelements, results[], outfile );
//	format results[0..nelements-1] as a comma separated
//      list onto outfile with lines <= maxw chars long.
//	produces a whole number of lines of output.
void print_int_array( int maxw, int nel, int *results, FILE *out )
{
	int linelen = 0;
	for( int i=0; i<nel; i++ )
	{
		char buf[100];
		sprintf( buf, "%d", results[i] );
		int len = strlen(buf);
		if( linelen + len + 2 > maxw )
		{
			fputc( '\n', out );
			linelen = 0;
		} else if( i>0 )
		{
			fputc( ' ', out );
			linelen++;
		}

		linelen += len;
		fprintf( out, "%s", buf );
		if( i<nel-1 )
		{
			fputc( ',', out );
			linelen++;
		}
	}
	//if( linelen>0 )
	//{
	//	fputc( '\n', out );
	//}
}
