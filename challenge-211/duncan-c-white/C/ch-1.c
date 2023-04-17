// Task 1: Toeplitz Matrix
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


// int nch = countch( target, str );
//	Count and return the number of occurrences of target in str.
//
int countch( char target, char *str )
{
	int n=0;
	for( ; *str; str++ )
	{
		if( *str == target ) n++;
	}
	return n;
}


// init_row( rp, rowdata, ncols );
//	initialize the ncols values in the row (rp) from rowdata,
//	modifying rowdata slightly (replacing ','s with '\0's)
//
void init_row( int *rp, char *rowdata, int ncols )
{
	int n = 1 + countch(',', rowdata);
	if( n != ncols )
	{
		fprintf( stderr, "All rows need %d columns - not %d\n",
			ncols, n );
		exit(1);
	}

	char *p, *q;
	for( p = rowdata; (q = strchr(p,',')) != NULL; p=q+1 )
	{
		*q = '\0';
		*rp++ = atoi(p);
	}
	*rp++ = atoi(p);
}


// show_matrix( m, nrows, ncols );
//	Display the given matrix.
//
void show_matrix( int **m, int nrows, int ncols )
{
	for( int i=0; i<nrows; i++ )
	{
		printf( "[ " );
		for( int j=0; j<ncols; j++ )
		{
			if( j>0 ) putchar(',');
			printf( "%d", m[i][j] );
		}
		printf( " ]\n" );
	}
}


//
// bool same = samediag(r,c,rows,cols,m);
//	Return true iff all matrix cells in m[][] down the
//	top-left->bottom-right diagonal starting at (r,c)
//	are the same value; false otherwise.
//
bool samediag( int r, int c, int rows, int cols, int **m )
{
	for( int v = m[r][c]; r<rows && c<cols; r++, c++ )
	{
		if( m[r][c] != v ) return false;
	}
	return true;
}


//
// bool istp = toeplitz( rows, cols, m );
//	return true iff m[rows][cols] is a toeplitz matrix, false otherwise
//
bool toeplitz( int rows, int cols, int **m )
{
	for( int r=rows-2; r>=0; r-- )
	{
		if( ! samediag(r,0,rows,cols,m) ) return false;
	}
	for( int c=1; c<cols-1; c++ )
	{
		if( ! samediag(0,c,rows,cols,m) ) return false;
	}
	return true;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "toeplitz-matrix", argc, argv,
		1, 1000, "list(row)" );

	int nrows = argc-argno;
	int ncols = 1 + countch(',', argv[argno] );
	if( debug )
	{
		printf( "debug: nrows = %d, ncols = %d\n", nrows, ncols );
	}

	int **m = malloc( nrows * sizeof(int *) );
	assert( m != NULL );
	for( int i=0; i<nrows; i++ )
	{
		m[i] = malloc( ncols * sizeof(int) );
		assert( m[i] != NULL );
		init_row( m[i], argv[argno++], ncols );
	}

	if( debug )
	{
		printf( "debug: matrix:\n" );
		show_matrix( m, nrows, ncols );
		putchar( '\n' );
	}

	bool is = toeplitz( nrows, ncols, m );
	printf( "%s\n", is ? "true" : "false" );

	for( int i=0; i<nrows; i++ )
	{
		free( m[i] );
	}
	free( m );

	return 0;
}
