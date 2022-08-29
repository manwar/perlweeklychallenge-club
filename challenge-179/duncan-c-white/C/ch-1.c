//
// Task 1: Ordinal Number Spelling
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


// rules to deal with "formwords"..

char *oneto19[] = {
	"one", "two", "three", "four", "five", "six", "seven", "eight",
	"nine", "ten", "eleven", "twelve", "thirteen", "fourteen",
	"fifteen", "sixteen", "seventeen", "eighteen", "nineteen"
	};

char *tens[] = {
	"twenty", "thirty", "forty", "fifty", "sixty", "seventy",
	"eighty", "ninety"
	};


// char words[1000];
// inner_formwords( n, words );
//	Generate the English form of n, writing it into words.
//	eg if n=17, set words to "seventeen".
void inner_formwords( int n, char *words )
{
	if( n < 20 )
	{
		strcpy( words, oneto19[n-1] );
		return;
	}

	if( n < 100 )
	{
		char *t = tens[n/10-2];
		if( debug )
		{
			printf( "debug: n=%d, tens=%s\n", n, t );
		}
		strcpy( words, t );
		if( n % 10 != 0 )
		{
			strcat( words, "-" );
			strcat( words, oneto19[n%10-1] );
		}
		return;
	}

	if( n < 1000 )
	{
		int mod = n%100;
		n /= 100;
		strcpy( words, oneto19[n-1] );
		strcat( words, "-hundred" );
		if( mod != 0 )
		{
			strcat( words, "-and-" );
			inner_formwords( mod, words+strlen(words) );
		}
		return;
	}

	if( n < 1000000 )
	{
		int mod = n%1000;
		n /= 1000;
		inner_formwords( n, words );
		strcat( words, "-thousand" );
		if( mod != 0 )
		{
			strcat( words, "-and-" );
			inner_formwords(mod, words+strlen(words) );
		}
		return;
	}
}


// remove_extra_ands( words );
//	If the string words contains more than one "-and-",
//	remove excess "and-"s leaving only the last.
//
void remove_extra_ands( char *words )
{
	for(;;)
	{
		// locate the first -and-, if any
		char *fst = strstr( words, "-and-" );
		if( fst == NULL ) return;

		// locate the second -and-, if any
		char *snd = strstr( fst+1, "-and-" );
		if( snd == NULL ) return;

		if( debug )
		{
			printf( "found two -and-s in %s\n", words );
		}

		// remove the first
		char *d = fst+1;
		for( char *s = fst+5; *s; *d++ = *s++ )
		{
			/*EMPTY*/
		}
		*d = '\0';

		if( debug )
		{
			printf( "removed the first leaving %s\n", words );
		}

	}
}


//
// char words[1000];
// formwords( n, words );
//	Generate the English form of n, writing it into words,
//	checking the range of n, and removing surplus "-and-"s.
//	eg if n=17, set words to "seventeen".
//
void formwords( int n, char *words )
{
	if( n < 1 )
	{
		fprintf( stderr, "formwords: n (%d) must be > 0\n", n );
		exit(1);
	}
	if( n >= 1000000 )
	{
		fprintf( stderr, "formwords: n (%d) must be < 1000000\n", n );
		exit(1);
	}

	inner_formwords( n, words );

	remove_extra_ands( words );
}


// rules to do with "nth" logic

// a useful type..
typedef struct { char *from; char *to; } pair;


// special cases, eg "one" -> "first".. 
pair special[] = {
	{ "one", "first" },
	{ "two", "second" },
	{ "three", "third" },
	{ "five", "fifth" },
	{ "eight", "eighth" },
	{ "twelve", "twelfth" },
};


#define NSPECIALS (sizeof(special)/sizeof(special[0]))


//
// char *spec = lookup_special( word );
//	Lookup word to see if it's special;
//	return NULL if it's not, or the equivalent
//	of the special word if it is.
//
char *lookup_special( char *word )
{
	for( int i=0; i < NSPECIALS; i++ )
	{
		if( strcmp( special[i].from, word ) == 0 )
		{
			return special[i].to;
		}
	}
	return NULL;
}


//
// char words[1000];
// nth( n, words );
//	Generate the "nth" English form of n in words,
//	eg if n=17, set words to "seventeenth".  Do it using formwords()
//	and then mucking about with the ending..
//
void nth( int n, char *words )
{
	formwords( n, words );

	char *dash = strchr( words, '-' );
	char prefix[1000];
	char lastbit[1000];

	if( dash != NULL )
	{
		*dash = '\0';
		strcpy( prefix, words );
		strcpy( lastbit, dash+1 );
	} else
	{
		strcpy( prefix, "" );
		strcpy( lastbit, words );
	}

	char *spec = lookup_special( lastbit );
	if( spec != NULL )
	{
		strcpy( lastbit, spec );
	}
	else
	{
		char *last = lastbit+strlen(lastbit)-1;
		if( *last == 'y' )
		{
			strcpy( last, "ie" );
		}
		strcat( lastbit, "th" );
	}

	if( *prefix != '\0' )
	{
		sprintf( words, "%s-%s", prefix, lastbit );
	} else
	{
		strcpy( words, lastbit );
	}
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "nth", argc, argv,
		1, "N (0..999999)" );
	char *arg = argv[argno]; // N

	int n;
	if( !check_unsigned_int(arg,&n) )
	{
		fprintf( stderr, "nth: arg %s must be +int\n", arg );
		exit(1);
	}
	char words[1000];
	//formwords( n, words );
	nth( n, words );
	//printf( "n=%d, word=%s\n", n, words );
	printf( "%s\n", words );
	return 0;
}
