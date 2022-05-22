// MySVG: simple SVG routines

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "MySVG.h"

/*
 * start_svg( w, h );
 *	Generate the xml, doctype and svg tags, width $w by height $h
 */
void start_svg( int w, int h )
{
	printf( "<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>\n" );
	printf( "<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">\n" );
	printf( "<svg width=\"%d\" height=\"%d\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\">\n", w, h );
}



/*
 * end_svg();
 *	Generate the end svg tag at the end of our svg document
 */
void end_svg( void )
{
	printf( "</svg>\n" );
}


static char colour[100] = "red";
static int linewidth = 4;


/*
 * setcolour( colourname );
 *	Set the current colour.
 */
void setcolour( char *colourname )
{
	strcpy( colour, colourname );
}



/*
 * setlinewidth( lw );
 *	Set the line width.
 */
void setlinewidth( int lw )
{
	linewidth = lw;
}





/*
 * point( x, y );
 *	Plot a point.
 */
void point( int x, int y )
{
	printf( "   <circle cx=\"%d\" cy=\"%d\" r=\"1\" fill=\"%s\" stroke-width=\"0\" />\n", x, y, colour );
}


/*
 * line( x1, y1, x2, y2 );
 *	Draw a line from (x1,y1) to (x2,y2)
 */
void line( int x1, int y1, int x2, int y2 )
{
	printf( "   <line x1=\"%d\" y1=\"%d\" x2=\"%d\" y2=\"%d\" stroke=\"%s\" stroke-width=\"%d\" />\n",
		x1, y1, x2, y2, colour, linewidth );
}


/*
 * rect( x1, y1, x2, y2 );
 *	Draw a rectangle from (x1,y1) to (x2,y2)
 */
void rect( int x1, int y1, int x2, int y2 )
{
	int w = 1+x2-x1;
	int h = 1+y2-y1;
	printf( "   <rect x1=\"%d\" y1=\"%d\" width=\"%d\" height=\"%d\" fill=\"white\" stroke=\"%s\" stroke-width=\"%d\" />\n",
		x1, y1, w, h, colour, linewidth );
}
