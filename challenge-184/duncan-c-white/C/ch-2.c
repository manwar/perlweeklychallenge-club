//
// Task 2: Split Array
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


//
// process_one_el( el, outp, wantnum, appanyp );
//	Given an element string argument (el), which should be EITHER be a
//	number or a letter/word, and an output pointer outp, and a boolean
//	(wantnum) telling us whether to search for numbers or letters, and
//	a ptr-to-a-boolean (appanyp) which says whether or not we've yet
//	appended anything to outp, check whether the element should
//	be included, and append it to outp if it is, modifying *appanyp.
//
static void process_one_el( char *el, char *outp, bool wantnum, bool *anyp )
{
	if( debug )
	{
		printf( "debug: pel: el=%s\n", el );
	}

	if( ! (wantnum && isdigit(*el)) && ! ( !wantnum && isalpha(*el)) )
	{
		return;
	}

	for( ; *outp; outp++ ) /*EMPTY*/;

	if( debug )
	{
		printf( "debug: pel: good el=%s, outp=%s\n", el, outp );
	}

	if( ! *anyp )
	{
		*outp++ = '[';
		*anyp = true;
	} else
	{
		*outp++ = ',';
	}
	strcpy( outp, el );
}


//
// onepass( arg, outp, wantnum );
//	Given a modifiable string argument (arg), which should be a
//	space-sep-values-string, and an output pointer outp, and a boolean
//	(wantnum) telling us whether to search for numbers (if wantnum)
//	or letters (if !wantnum), append well formatted lists of such elements
//	from arg to outp.
//
static void onepass( char *arg, char *outp, bool wantnum )
{
	bool appany = false;	// have we yet appended anything to outp?

	char *p;
	char *end;
	for( p=arg; (end=strchr(p,' '))!= NULL; p=end+1 )
	{
		*end = '\0';
		process_one_el( p, outp, wantnum, &appany );
		*end = ' ';
	}
	process_one_el( p, outp, wantnum, &appany );
	if( appany )
	{
		strcat( outp, "], " );
	}
}


//
// process( char *arg, char *letp, char *nump );
//	Given a string argument (arg), which should be a csv-string
//	and a letter-string-pointer (letp) and a number-string-pointer (nump)
//	append well formatted lists of letters in arg to letp, and
//	append well formatted lists of numbers in arg to letp.
//
static void process( char *arg, char *letp, char *nump )
{
	// convert commas to spaces
	for( char *p=arg; *p; p++ )
	{
		if( *p == ',' ) *p = ' ';
	}

	// append any numbers in arg to nump
	onepass( arg, nump, true );

	// append any letters in arg to letp
	onepass( arg, letp, false );
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "split-array", argc, argv,
		1, 100000, "array of csv-strings" );

	int numstrings = argc-argno;
	if( debug )
	{
		printf( "debug: numstrings=%d\n", numstrings );
	}

	char letstr[1024];
	char numstr[1024];
	strcpy( letstr, "" );
	strcpy( numstr, "" );

	char *lp = letstr;
	char *np = numstr;

	int i;
	for( i=argno; i<argc; i++ )
	{
		process( argv[i], lp, np );
		lp += strlen(lp);
		np += strlen(np);
	}
	numstr[strlen(numstr)-2] = '\0';
	letstr[strlen(letstr)-2] = '\0';

	printf( "Output: [%s] and [%s]\n", numstr, letstr );

	return 0;
}
