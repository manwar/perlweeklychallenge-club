/*
 * TASK 1: Scalable Vector Graphics (SVG)
 * 
 * Example:
 * 
 * 53,10
 * 53,10,23,30
 * 23,30
 *
 * GUEST LANGUAGE: This is my attempt to translate ch-1.pl and MySVG.pm into C
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <ctype.h>
#include <assert.h>

#include "MySVG.h"

bool debug=0;

// process_noarg( argc, argv );
//	Process the -d flag, and check that there are NO
//	arguments left.
void process_noarg( int argc, char **argv )
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
			"Usage: mk-svg [-d] < inputfile\n" );
		exit(1);
	}
}


typedef struct { int x, y; } datapoint;
typedef struct { int x1, y1, x2, y2; } dataline;

#define MAXITEMS 1024

int npoints = 0;
datapoint pt[MAXITEMS]; 	// input points
int nlines = 0;
dataline ln[MAXITEMS];	// lines, each line an [x1,y1,x2,y2] tuple

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
 *	Read data (points and lines) from in.
 */
void read_data( FILE *in )
{
	#define MAXLINELEN 100
	char line[MAXLINELEN];

	npoints = 0;
	nlines = 0;
	while( readline(in, line, MAXLINELEN ) )
	{
		int x1, y1, x2, y2;
		char *s;
		char *p;

		s = line;
		assert( isdigit(*s) );
		p = strchr(s,',');
		assert( p != NULL );
		*p = '\0';
		x1 = atoi(s);

		s = p+1;
		assert( isdigit(*s) );
		y1 = atoi(s);
		p = strchr(s,',');

		if( p != NULL )		// must be a line
		{
			*p = '\0';

			s = p+1;
			assert( isdigit(*s) );
			p = strchr(s,',');

			assert( p != NULL );
			*p = '\0';
			x2 = atoi(s);

			s = p+1;
			assert( isdigit(*s) );
			y2 = atoi(s);

			//printf( "debug: read line %d,%d, %d,%d\n", x1, y1, x2, y2 );
			ln[nlines].x1 = x1;
			ln[nlines].y1 = y1;
			ln[nlines].x2 = x2;
			ln[nlines].y2 = y2;
			nlines++;
			updatewh( x1, y1 );
			updatewh( x2, y2 );
		} else
		{
			//printf( "debug: read point %d,%d\n", x1, y1 );
			pt[npoints].x = x1;
			pt[npoints].y = y1;
			npoints++;
			updatewh( x1, y1 );
		}
	}

}

int main( int argc, char **argv )
{
	process_noarg( argc, argv );

	wh.x = -1;
	wh.y = -1;

	read_data( stdin );

	int w = wh.x;
	int h = wh.y;

	w += (10-w%10);
	h += (10-h%10);

	int xscale = w < 200 ? 200/w : 1;
	int yscale = h < 200 ? 200/h : 1;

	fprintf( stderr, "maxxy rectangle is w %d, h %d, xscale %d, yscale %d\n", w, h, xscale, yscale );

	start_svg( w * xscale, h * yscale );

	setcolour( "blue" );
	setlinewidth( 1 );
	for( int i=0; i<nlines; i++ )
	{
		// printf( "debug: generating line for ln[%d]: %d,%d, %d,%d\n",
		// 	i, ln[i].x1, ln[i].y1, ln[i].x2, ln[i].y2 );
		line( ln[i].x1*xscale, ln[i].y1*yscale,
		      ln[i].x2*xscale, ln[i].y2*yscale );
	}

	setcolour( "orange" );
	for( int i=0; i<npoints; i++ )
	{
		point( pt[i].x*xscale, pt[i].y*yscale );
	}

	end_svg();

	return 0;
}
