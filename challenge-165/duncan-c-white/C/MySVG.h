// MySVG: simple SVG routines

extern void start_svg( int w, int h );
extern void end_svg( void );
extern void setcolour( char *colourname );
extern void setlinewidth( int lw );
extern void point( int x, int y );
extern void line( int x1, int y1, int x2, int y2 );
extern void rect( int x1, int y1, int x2, int y2 );
