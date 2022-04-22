/* 
 * TASK #1 - Four Is Magic - done in C.
 * MY NOTES: ok.  Pretty easy.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

char *n_to_word[] = {
	"zero",
	"one",
	"two",
	"three",
	"four",
	"five",
	"six",
	"seven",
	"eight",
	"nine"
};


bool debug = false;


/*
 * int n = process_args( argc, argv );
 *   Process cmd line options (setting debug if --debug/-d option given)
 *   and the optional value n (default 3), return n.
 *   My goodness, it's painful to write this sort of code..
 */
int process_args( int argc, char **argv )
{
	int pos = 1;
	if( argc > 1 &&
	    (strcmp( argv[1], "--debug" )==0 || strcmp( argv[1], "-d")==0 ) )
	{
		debug = true;
		pos++;
	}
	if( argc < pos )
	{
		fprintf( stderr,
		   "Usage: four-is-magic [--debug] [N] (default 3, < 10)\n" );
		exit(1);
	}
	int n = argc > pos ? atoi( argv[pos] ) : 3;
	if( n==0 ) n = 3;
	if( n < 0 || n > 9 )
	{
		fprintf( stderr, "four-is-magic: n ($n) must be 0..9\n" );
		exit(1);
	}
	return n;
}


int main( int argc, char **argv )
{
	int n = process_args( argc, argv );

	char *word = n_to_word[n];

	char answer[512];
	char *p = answer;

	while( strcmp( word, "four") != 0 )
	{
		int len = strlen(word);
		char *lenword = n_to_word[len];
		strcpy( p, word );
		strcat( p, " is " );
		strcat( p, lenword );
		strcat( p, ", " );
		p += strlen(p);
		if( debug )
		{
			printf( "debug: word=%s, len=%d, lenword=%s, "
			        "added '%s is %s'\n",
				word, len, lenword, word, lenword );
		}
		word = lenword;
	}

	strcpy( p, "four is magic." );

	puts( answer );
	return 0;
}
