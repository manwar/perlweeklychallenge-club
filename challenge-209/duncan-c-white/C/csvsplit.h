//
// csvsplit.h: simple CSV splitting (csvForeach), useful utility functions
//	       Now one function that strdup()s it's strings, another that
//	       modifies them in place.
//
// (C) Duncan C. White, May 2017-March 2023

// a csv foreach callback function takes
// a char * (the csv value split out)
// and a void * (an extra value).

typedef void (*csvforeachcb)( char *, void * );

extern void csvForeach( char * csvstring, csvforeachcb cb, void * extra );
extern void csvForeachstrdup( char * csvstring, csvforeachcb cb, void * extra );
