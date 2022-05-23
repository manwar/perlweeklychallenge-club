/*
 * Task 2: Line of Best Fit
 * 
 * GUEST LANGUAGE: This is my attempt to translate ch-2.pl into C
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>
#include <assert.h>

#include "MySVG.h"

bool debug=0;

// char *s = process_singlearg( argc, argv );
//	Process the -d flag, and check that there is a single
//	remaining argument, return it
char * process_singlearg( int argc, char **argv )
{
	int arg=1;
	if( argc>1 && strcmp( argv[arg], "-d" ) == 0 )
	{
		debug = true;
		arg++;
	}

	int left = argc-arg;
	if( left != 1 )
	{
		fprintf( stderr,
			"Usage: best-fit [-d] filename\n" );
		exit(1);
	}

	// element is in argv[arg]

	if( debug )
	{
		printf( "debug: remaining argument is in pos %d, and is %s\n",
			arg, argv[arg] );
	}

	return argv[arg];
}


typedef struct { int x, y; } datapoint;
typedef struct { int x1, y1, x2, y2; } dataline;

#define MAXITEMS 1024

int npoints = 0;
datapoint pt[MAXITEMS]; 	// input points

datapoint wh;		// wh.x == width of our data, wh.y == height of our data


/*
 * updatewh( x, y );
 *	Update wh to include x and y.
 */
void updatewh( int x, int y )
{
	assert( x>=0 );
	assert( y>=0 );
	if( x > wh.x ) wh.x = x;
	if( y > wh.y ) wh.y = y;
}


/*
 * bool lineread = readline( in, buf, maxlen );
 *      read a single line from in (a FILE * open for input)
 *      into a character buffer (char *), reading no more than
 *      maxlen characters, removing a trailing '\n' from the
 *      buffer (if there is one).
 *
 *      If the input line is longer than that, the REMAINDER OF
 *      THE LINE IS LEFT IN the file's input buffer for later reading.
 *      If readline() is called again immediately, the remainder of
 *      the line will be treated as a separate line.
 *
 *      In caller-space, buf must be a writable character buffer of
 *      size >= maxlen, i.e. typically either a char [n]
 *      or a malloc(n * sizeof(char)) chunk,
 *      where (in both cases) n >= maxlen
 */
bool readline( FILE *in, char *buf, int maxlen )
{
        if( fgets( buf, maxlen, in ) == 0 )
        {
                return false;
        }
        int l = strlen(buf);
        if( l>0 && buf[l-1]=='\n' )
        {
                buf[l-1] = '\0';
        }
        return true;
}


/*
 *
 * read_data( in );
 *	Read data (points) from in.
 */
void read_data( FILE *in )
{
	#define MAXLINELEN 100
	char line[MAXLINELEN];

	npoints = 0;
	while( readline(in, line, MAXLINELEN ) )
	{
		int x, y;
		char *s;
		char *p;

		s = line;
		assert( isdigit(*s) );
		p = strchr(s,',');
		assert( p != NULL );
		*p = '\0';
		x = atoi(s);

		s = p+1;
		assert( isdigit(*s) );
		y = atoi(s);

		//fprintf( stderr, "debug: read point %d,%d\n", x, y );
		pt[npoints].x = x;
		pt[npoints].y = y;
		npoints++;
		updatewh( x, y );
	}
}


/*
 * bestfit( points, npoints, &m, &c );
 *	Calculate y=mx+c, the best fit line of the data (each data point an [x,y] pair)
 */
void bestfit( datapoint *pt, int npoints, double *m, double *c )
{
	int sumx = 0;
	int sumy = 0;
	int sumxy = 0;
	int sumx2 = 0;
	for( int i=0; i<npoints; i++ )
	{
		int x = pt[i].x;
		int y = pt[i].y;
		sumx += x;
		sumy += y;
		sumxy += x * y;
		sumx2 += x * x;
	}

	*m = (npoints * sumxy - sumx * sumy) / (double) (npoints * sumx2 - sumx * sumx);
	*c = (sumy - *m * sumx) / (double)npoints;

	if( debug )
	{
		fprintf( stderr, "bestfit: n=%d, sumx=%d, sumy=%d, sumxy=%d, sumx^2=%d\n",
			npoints, sumx, sumy, sumxy, sumx2 );
		fprintf( stderr, "bestfit: m=%.6f, c=%.6f\n", *m, *c );
	}
}


int main( int argc, char **argv )
{
	char *filename = process_singlearg( argc, argv );

	wh.x = -1;
	wh.y = -1;

	FILE *in = fopen( filename, "r" );
	assert( in != NULL );
	read_data( in );
	fclose( in );

	int w = wh.x;
	int h = wh.y;

	w += (10-w%10);
	h += (10-h%10);

	int xscale = w < 200 ? 200/w : 1;
	int yscale = h < 200 ? 200/h : 1;

	if( debug )
	{
		fprintf( stderr, "maxxy rectangle is w %d, h %d, xscale %d, yscale %d\n", w, h, xscale, yscale );
	}

	double m, c;
	bestfit( pt, npoints, &m, &c );
	int y1 = (int) (m + c);			// for x==1
	int y2 = (int) (m * (w-1) + c);		// for x==w-1

	start_svg( w * xscale, h * yscale );

	setcolour( "blue" );
	setlinewidth( 1 );
	line( 1, y1*yscale, (w-1)*xscale, y2*yscale );

	setcolour( "orange" );
	for( int i=0; i<npoints; i++ )
	{
		point( pt[i].x*xscale, pt[i].y*yscale );
	}

	end_svg();

	return 0;
}
