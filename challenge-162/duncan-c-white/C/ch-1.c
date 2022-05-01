/* 
 * TASK #1 - ISBN-13
 * 
 * Write a script to generate the check digit of given ISBN-13 code. Please
 * refer to
 * 
 * https://en.wikipedia.org/wiki/ISBN#ISBN-13_check_digit_calculation
 * 
 * for more information.  In summary, take each of the first 12 digits of
 * an ISBN code, from left to right, multiple 1st, 3rd, 5th etc by 1, and
 * the 2nd, 4th, 6th etc by 3, sum the result.  Mod 10 the sum.  Subtract
 * the sum from 10.  Mod 10 the result.
 * 
 * Example
 * 
 * ISBN-13 check digit for '978-0-306-40615-7' is 7.
 * 
 * MY NOTES: ok.  Pretty easy.
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>
#include <ctype.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>




bool debug=false;


int main( int argc, char **argv )
{
	if( argc != 2 )
	{
		fprintf( stderr, "Usage: isbn-13 isbn-number\n" );
		exit(1);
	}
	char *input = argv[1];
	char isbn[14];

	// copy input to isbn, omitting the dashes
	char *dst = isbn;
	char *src = input;
	while( *src )
	{
		if( *src != '-' )
		{
			*dst++ = *src;
		}
		src++;
	}
	if( debug )
	{
		printf( "debug: isbn w/o dashes = %s\n", isbn );
	}

	// chop off the last digit if len==13, check length
	int len = strlen(isbn);
	if( len==13 )
	{
		isbn[12] = '\0';
		len--;
	}
	if( debug )
	{
		printf( "debug: isbn w/o checkdigit = %s\n", isbn );
	}
	if( len != 12 )
	{
		fprintf( stderr,
			"isbn-checker: length of %s (should be 12) is %d\n",
			isbn, len );
		exit(1);
	}

	int scale = 3;
	int total = 0;
	for( src = isbn; *src; src++ )
	{
		scale = 4-scale;
		total += scale * (*src-'0');
	}
	total %= 10;
	total = 10-total;
	total %= 10;

	printf( "%d\n", total );

	return 0;
}
