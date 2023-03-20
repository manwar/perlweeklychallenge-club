/*
 * csvsplit.h: simple CSV splitting (csvForeach) - doesn't handle
 *	       quoted fields with nested commas.
 *
 * (C) Duncan C. White, May 2017
 */

// a csv foreach callback function takes
// a char * (the csv value split out)
// and a void * (an extra value).

typedef void (*csvforeachcb)( char *, void * );

extern void csvForeach( char * csvstring, csvforeachcb cb, void * extra );
