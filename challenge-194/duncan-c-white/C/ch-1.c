//
// Task 1: Digital Clock
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


int countch(char *str, char ch)
{
	int n=0;
	for( ; *str; str++ )
	{
		if( *str==ch ) n++;
	}
	return n;
}


// char *errmesg = validate_date( date, &h1, &h2, &m1, &m2 );
//	Validate date <date>, if the date is valid, fill in h1, h2,
//	m1 and m2 and return NULL, otherwise return an error message.
char *validate_date( char *date, char *h1, char *h2, char *m1, char *m2 )
{
	static char err[100];
	if( strlen(date) != 5 )
	{
		sprintf( err, "hh:mm %s should be length 5\n", date );
		return err;
	}

	int nq = countch(date,'?');
	if( nq != 1 )
	{
		sprintf( err, "need 1 '?' in hh:mm str %s, not %d\n", date, nq );
		return err;
	}

	if( date[2] != ':' )
	{
		sprintf( err, "':' expected in hh:mm str %s\n", date );
		return err;
	}

	*h1 = date[0];
	*h2 = date[1];
	*m1 = date[3];
	*m2 = date[4];
	if( *h1!='0' && *h1!='1' && *h1!='2' && *h1!='?' )
	{
		sprintf( err, "h1 (%c) should be 0..2 or ?\n", *h1 );
		return err;
	}

	if( ! isdigit(*h2) && *h2!='?' )
	{
		sprintf( err, "h2 (%c) should be 0..9 or ?\n", *h2 );
		return err;
	}

	if( (*m1<'0' || *m1>'5') && *m1!='?' )
	{
		sprintf( err, "m1 (%c) should be 0..5 or ?\n", *m1 );
		return err;
	}

	if( ! isdigit(*m2) && *m2!='?' )
	{
		sprintf( err, "m2 (%c) should be 0..9 or ?\n", *m2 );
		return err;
	}

	if( *h1 == '2' && *h2 > '3' && *h2 != '?' )
	{
		sprintf( err, "hour %c%c must be 2[0..3]\n", *h1, *h2 );
		return err;
	}

	return NULL;
}


//
// int n = find_question( h1, h2, m1, m2 );
//	Given h1 (the first hour digit 0,1,2 or ?),
//	h2 (the second hour digit, 0-9 or ?),
//	m1 (the first minute digit 0-5 or ?) and
//	m2 (the second minute digit 0-9 or ?),
//	locate the question mark and find and return the maximum value
//	that cell could be.  Abort if there's no '?' anywhere.
//
int find_question( char h1, char h2, char m1, char m2 )
{
	if( h1 == '?' )
	{
		return ( h2 > '3' ) ? 1 : 2;
	}
	if( h2 == '?' )
	{
		return ( h1 == '2' ) ? 3 : 9;
	}
	if( m1 == '?' ) return 5;
	if( m2 == '?' ) return 9;
	fprintf( stderr, "no question mark found in %c%c:%c%c\n",
		h1, h2, m1, m2 );
	exit(1);
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "digital-clock", argc, argv, 1, "" );
	char *arg = argv[argno];

	if( debug )
	{
		printf( "debug: arg=%s\n", arg );
	}

	char h1, h2, m1, m2;
	char *mesg = validate_date( arg, &h1, &h2, &m1, &m2 );
	if( mesg != NULL )
	{
		fprintf( stderr, "digital-clock: %s\n", mesg );
		exit(1);
	}

	int result = find_question( h1, h2, m1, m2 );
	printf( "%d\n", result );

	return 0;
}
