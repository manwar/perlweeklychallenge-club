//
// Task 2: Seven Segment 200
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


//
// init_blank( arr, ndigits );
//	Initialize and blank the 7 element array of char * strings.
//
void init_blank( char **arr, int ndigits )
{
	for( int i=0; i<7; i++ )
	{
		int len = 9 * ndigits + 1;
		arr[i] = malloc( len );
		assert( arr[i] != NULL );
		for( int j=0; j<len-1; j++ )
		{
			arr[i][j] = ' ';
		}
		arr[i][len] = '\0';
	}
}


int truth[] = { 0x3f, 6, 1+2+8+16+64, 1+2+4+8+64, 2+4+32+64,
		1+4+8+32+64, 1+4+8+16+32+64, 7, 0x7f, 1+2+4+32+64 };


//
// hline( result, pos, sx, ex, row );
//	Draw a horizontal line into the 9 chars of result[][pos..]
//	from (sx,y) to (ex,y).
//
void hline( char **result, int pos, int sx, int ex, int y )
{
	for( int i=sx; i<=ex; i++ )
	{
		result[y][9*pos+i] = '-';
	}
}


//
// vline( result, pos, x, sy, ey );
//	Draw a vertical line into the last 9 chars of @$result 
//	from (x,sy) to (x,ey).
//
void vline( char **result, int pos, int x, int sy, int ey )
{
	for( int i=sy; i<=ey; i++ )
	{
		result[i][9*pos+x] = '|';
	}
}


//
// append_digit( digit, pos, results );
//	Write 7-segment version of digit (0..9) into position
//	pos in results (7-element char array).
//
void append_digit( int digit, int pos, char **results )
{
	int bitmap = truth[digit];
	if( bitmap & 1 ) hline( results, pos, 1, 5, 0 );
	if( bitmap & 2 ) vline( results, pos, 6, 1, 2 );
	if( bitmap & 4 ) vline( results, pos, 6, 4, 5 );
	if( bitmap & 8 ) hline( results, pos, 1, 5, 6 );
	if( bitmap & 16 ) vline( results, pos, 0, 4, 5 );
	if( bitmap & 32 ) vline( results, pos, 0, 1, 2 );
	if( bitmap & 64 ) hline( results, pos, 1, 5, 3 );
}


int main( int argc, char **argv )
{
	int arg = process_flag_n_args( "7-segments", argc, argv, 1, "int" );

	int n = atoi( argv[arg] );

	// find out ndigits and pow10
	int ndigits = 1;
	int pow10 = 1;
	for( int i=n; i>9; i/=10 )
	{
		ndigits++;
		pow10 *= 10;
	}

	if( debug )
	{
		printf( "debug: n=%d, ndigits=%d, pow10=%d\n", n, ndigits, pow10 );
	}

	// ok, blank the results..
	char *results[7];
	init_blank( results, ndigits );

	for( int i=0; i<ndigits; i++ )
	{
		int digit = n / pow10;
		n %= pow10;
		pow10 /= 10;
		append_digit( digit, i, results );
	}

	// show the results
	for( int i=0; i<7; i++ )
	{
		printf( "%s\n", results[i] );
	}

	// free the results
	for( int i=0; i<7; i++ )
	{
		free( results[i] );
	}
	return 0;
}
