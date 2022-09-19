/* 
 * Task 2 - Kronecker Product
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-2.pl.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>
#include <ctype.h>



bool debug=false;

#define MAXROWS 20
#define MAXCOLS 20
typedef int matrix[MAXROWS][MAXCOLS];



// process_flag_noarg( argc, argv );
//	Process the -d flag, and check that there are no
//	remaining arguments.
void process_flag_noarg( int argc, char **argv )
{
	int arg=1;
	if( argc>1 && strcmp( argv[arg], "-d" ) == 0 )
	{
		debug = true;
		arg++;
	}

	int left = argc-arg;
	if( left != 0 )
	{
		fprintf( stderr,
			"Usage: kronecker-product [-d]\n" );
		exit(1);
	}
}


//
// mat_show( m, rows, cols );
//	Show matrix m
//
void mat_show( matrix m, int rows, int cols )
{
	// first, calculate the max cell width
	int width = 1;
	for( int i=0; i<rows; i++ )
	{
		for( int j=0; j<cols; j++ )
		{
			char buf[128];
			sprintf( buf, "%d", m[i][j] );
			int len = strlen(buf);
			if( len > width )
			{
				width = len;
			}
		}
	}
	#if 0
	fprintf( stderr, "width=%d\n", width );
	exit(1);
	#endif

	for( int i=0; i<rows; i++ )
	{
		fputs( "[ ", stdout );
		for( int j=0; j<cols; j++ )
		{
			printf( "%*d ", width, m[i][j] );
		}
		putchar( ']' );
		putchar( '\n' );
	}
}


//
// kronecker_product( a, ar, ac, b, br, bc, c, &rows, &cols );
//	Form the Kronecker product of two matrices A (ar rows x ac cols)
//	and B (br rows x bc cols) in C (and setting rows and cols
//	to the dimensions of C).
//	using the formula (A x B)i,j = Ai/p,j/q * Bi%p,j%q
//	[where B is of size p x q]
//
void kronecker_product( matrix a, int m, int n, matrix b, int p, int q, matrix c, int *rp, int *cp )
{
	int rows = m * p;
	int cols = n * q;
	//fprintf( stderr, "rows=%d, cols=%d\n", rows, cols );

	for( int i=0; i<rows; i++ )
	{
		int arow = i / p;
		int brow = i % p;
		for( int j=0; j<cols; j++ )
		{
			int acol = j / q;
			int bcol = j % q;

			c[i][j] = a[arow][acol] * b[brow][bcol];
		}
	}
	*rp = rows;
	*cp = cols;
}


void small( void )
{
	matrix a = { {1,2}, {3,4} };
	//mat_show( a, 2, 2 );

	matrix b = { {5, 6}, {7, 8} };
	//mat_show( b, 2, 2 );

	puts( "[ 1, 2 ]       [5, 6]" );
	puts( "[ 3, 4 ]   k*  [7, 8]" );
	puts( "is:" );

	matrix c;
	int rows, cols;
	kronecker_product( a, 2, 2, b, 2, 2, c, &rows, &cols );
	mat_show( c, rows, cols );
}


void big( void )
{
	matrix a = { {1,-4,7}, {-2,3,3} };
	//mat_show( a, 2, 3 );

	matrix b = {
		{8, -9, -6, 5},
		{1, -3, -4, 7},
		{2, 8, -8, -3},
		{1, 2, -5, -1},
	};
	//mat_show( b, 4, 4 );

	puts( "[ 1, -4, 7 ]       [8, -9, -6, 5]" );
	puts( "[ -2, 3, 3 ]       [1, -3, -4, 7]" );
	puts( "               k*  [2, 8, -8, -3]" );
	puts( "                   [1, 2, -5, -1]" );
	puts( "is:" );

	matrix c;
	int cr, cc;
	kronecker_product( a, 2, 3, b, 4, 4, c, &cr, &cc );
	mat_show( c, cr, cc );
}


int main( int argc, char **argv )
{
	process_flag_noarg( argc, argv );

	small();
	putchar( '\n' );
	big();

	return 0;
}
