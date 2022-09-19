/*
 *   readline.h: utility functions to readline arbitrarily
 *		 long lines w/o overflow..
 */

extern bool readline( FILE * in, char * buf, int maxlen );
extern bool readline_discardrest( FILE * in, char * buf, int maxlen );
