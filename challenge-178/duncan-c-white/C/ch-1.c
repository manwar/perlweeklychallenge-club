//
// Task 1: Quater-imaginary Base conversion
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

#define BUFSIZE 100


//
// reverse( str );
//	reverse str in place
void reverse( char *str )
{
	char *p = str + strlen(str) - 1;
	for( char *q=str; q<p; q++, p-- )
	{
		char t = *p;
		*p = *q;
		*q = t;
	}
}


//
// char b4str[BUFSIZE];
// convert_to_base_neg4( x, b4str );
//	Convert +int x to base -4, storing the base-4 numeral into b4str.
//
void convert_to_base_neg4( int x, char *b4str )
{
	int origx = x;
	*b4str = '\0';
	char *p = b4str;
	while( abs(x)>0 )
	{
		int d = x/-4;
		int m = x + 4*d;
		if( m < 0 )
		{
			m += 4;
			d++;
		}
		if( debug )
		{
			printf( "debug: c_t_b-4(%d): x=%d, d=%d, m=%d\n",
				origx, x, d, m );
		}
		*p++ = m+'0';
		x = d;
	}
	*p = '\0';

	if( p == b4str )
	{
	  *p++ = '0';
	  *p = '\0';
	}

	reverse( b4str );

	if( debug )
	{
		printf( "debug: c_t_b-4(%d): result = %s\n", origx, b4str );
	}
}


//
// my $qistr = convert_to( $n );
//	Convert +int $n to q-i, return the q-i numeral.
//
// char qistr[BUFSIZE];
// convert_to( x, qistr );
//	Convert +int x to qi base, storing the qi numeral into qistr.
//
void convert_to( int x, char *qistr )
{
	char b4str[BUFSIZE];
	convert_to_base_neg4( x, b4str );

	if( debug )
	{
		printf( "debug: to(%d) base-4 = %s\n", x, b4str );
	}

	// copy the b4str to qistr, adding '0' between every pair of digits
	char *s = b4str;
	char *d=qistr; 

	*d++ = *s++;

	for( ; *s; s++ )
	{
		*d++ = '0';
		*d++ = *s;
	}
}


//
// int n = convert_from_base_neg4( char *bstr );
//	Given bstr, a base -4 numeral representing a +int,
//	return that int.
//
int convert_from_base_neg4( char *bstr )
{
	int n = 0;
	int currpow = 1;
	int len = strlen(bstr)-1;
	for( char *p= bstr+len; p>=bstr; p-- )
	{
		int d = *p-'0';
		if( debug )
		{
			printf( "debug: c_f_b-4(%s): digit %d, currpow %d, "
			    "n %d\n", bstr, d, currpow, n );
		}
		n += d * currpow;
		currpow *= -4;
	}
	if( debug )
	{
		printf( "debug: c_f_b-4(%s): result is %d\n", bstr, n );
	}
	return n;
}


//
// int n = convert_from( char *qinum );
//	Given a q-i numeral qinum (a string using only digits 0..3),
//	convert it from q-i to a plain +int.
//
int convert_from( char *qinum )
{
	char bstr[BUFSIZE];

	// convert qinum into a base -4 string, checking that the
	// imaginary columns in qinum are all 0 as we go.
	*bstr = '\0';
	bool odd = false;
	char *d = bstr;
	char *s;
	for( s = qinum; *s; s++ ) /*EMPTY*/;
	s--;
	for( ; s>=qinum; s-- )
	{
		char dig = *s;
		if( odd )
		{
			if( dig != '0' )
			{
				fprintf( stderr, "convert_from( %s ): digit %c"
				    " should be zero\n", qinum, dig );
				exit(1);
			}
		} else
		{
			*d++ = dig;
		}
		odd = !odd;
	}
	*d = '\0';
	if( bstr[0] == '\0' )
	{
		bstr[0] = '0';
		bstr[1] = '\0';
	}

	reverse( bstr );

	if( debug )
	{
		printf( "debug: cf(%s), bstr = %s\n", qinum, bstr );
	}

	// now convert that..
	return convert_from_base_neg4( bstr );
}


//
// bool ok = validate_all0to3( val );
//	Return true iff val only contains [0-3] digits.
//
bool validate_all0to3( char *val )
{
	int bad=0;
	for( char *p=val; *p; p++ )
	{
		if( *p < '0' || *p > '3' ) bad++;
	}
	return bad==0;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "quater-imaginary-base", argc, argv,
		2, "to/tobase-4/from/frombase-4/check val" );
	char *dir = argv[argno++]; // to/tobase-4/from/frombase-4/check
	char *val = argv[argno];   // value string (either +int or qistr)

	if( strcmp( dir, "to" ) == 0 )
	{
		int n;
		if( !check_unsigned_int(val,&n) )
		{
			fprintf( stderr, "quater-imaginary-base: to %s: "
				"must be +int\n", val );
			exit(1);
		}
		if( debug )
		{
			printf( "debug: to(%d)\n", n );
		}
		char cistr[BUFSIZE];
		convert_to( n, cistr );
		printf( "%s\n", cistr );
	} else if( strcmp( dir, "tobase-4" ) == 0 )
	{
		int n;
		if( !check_unsigned_int(val,&n) )
		{
			fprintf( stderr, "quater-imaginary-base: tobase-4 "
				"%s: must be +int\n", val );
			exit(1);
		}
		if( debug )
		{
			printf( "debug: to(%d)\n", n );
		}
		char b4str[BUFSIZE];
		convert_to_base_neg4( n, b4str );
		printf( "%s\n", b4str );
	} else if( strcmp( dir, "from" ) == 0 )
	{
		bool ok = validate_all0to3( val );
		if( !ok )
		{
			fprintf( stderr, "quater-imaginary-base: from %s: "
				"all digits must be 0..3\n", val );
			exit(1);
		}
		int n = convert_from( val );
		printf( "qi value %s = %d\n", val, n );
	} else if( strcmp( dir, "frombase-4" ) == 0 )
	{
		bool ok = validate_all0to3( val );
		if( !ok )
		{
			fprintf( stderr, "quater-imaginary-base: frombase-4 "
				"%s: all digits must be 0..3\n", val );
			exit(1);
		}
		int n = convert_from_base_neg4( val );
		printf( "base -4 value %s = %d\n", val, n );
	} else if( strcmp( dir, "check" ) == 0 )
	{
		int n;
		if( !check_unsigned_int(val,&n) )
		{
			fprintf( stderr, "quater-imaginary-base: check %s: "
				"must be +int\n", val );
			exit(1);
		}
		printf( "checking first %d conversions back-convert ok\n", n );
		for( int x=0; x<n; x++ )
		{
			char cistr[BUFSIZE];
			convert_to( x, cistr );
			//printf( "%s\n", cistr );

			int back = convert_from( cistr );
			assert( x==back );
		}
	} else
	{
		fprintf( stderr, "quater-imaginary-base: direction %s must "
		    "be to/tobase-4/from/frombase-4/check\n", dir );
		exit(1);
	}
	return 0;
}
