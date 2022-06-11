/* 
 * TASK #1 - Abecedarian Words
 * 
 * An abecedarian word is a word whose letters are arranged in alphabetical
 * order. For example, 'knotty' is an abecedarian word, but 'knots'
 * is not. Output or return a list of all abecedarian words in the
 * dictionary, sorted in decreasing order of length.
 * 
 * Optionally, using only abecedarian words, leave a short comment in
 * your code to make your reviewer smile.
 * 
 * MY NOTES: ok.  Pretty easy.  Amusing phrase:
 * "I am not a cellos guy"  (Jealous Guy, Roxy Music)
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




/*
 * bool isabeced = is_abeced( char *word );
 *	Return true iff word is an Abecedarian-word, i.e. all
 *	it's letters are in sorted order.
 */
bool is_abeced( char *word )
{
	int len = strlen(word);
	for( int i=0; i<len-1; i++ )
	{
		//printf( "debug: i=%d, w[i]=%c, w[i+1]=%c\n",
		//	i, word[i], word[i+1] );
		if( word[i] > word[i+1] )
		{
			return false;
		}
	}
	//printf( "debug: word %s is abecedarian\n", word );
	return true;
}

bool debug=false;
#define DICTFILE "../dictionary.txt"


int compareword(const void *av, const void *bv)
{
	char **a = (char **)av;
	char **b = (char **)bv;
	//printf( "debug: cw: a=%s, b=%s\n", *a, *b );
	int x = strlen(*b) - strlen(*a);		// descending order
	if( x != 0 ) return x;
	return strcmp(*a,*b);
}


int main( void )
{
	#if 0
	bool isabeced = is_abeced( "hello" );
	printf( "debug: abeced(hello)=%d\n", (int)isabeced );
	exit(1);
	isabeced = is_abeced( "xv" );
	printf( "debug: abeced(xv)=%d\n", (int)isabeced );
	exit(1);
	#endif

	struct stat st;
	if( stat( DICTFILE, &st ) != 0 )
	{
		fprintf( stderr, "Abecedarian-words: can't stat " DICTFILE );
		exit(1);
	}
	int size = st.st_size;

	// Allocate a dictionary buffer for all dictionary words
	char *dictbuf = malloc( size+1 );
	assert( dictbuf != NULL );

	// allocate an equivalent buffer for abecedarian words
	char *abecbuf = malloc( size+1 );
	assert( abecbuf != NULL );

	// read the entire dictionary into dictbuf in one fell swoop
	int fd = open( DICTFILE, O_RDONLY );
	assert( fd != -1 );
	int haveread = read(fd, dictbuf, size);
	assert( haveread==size );
	dictbuf[size-1] = '\0';
	close(fd);

	// modify the dictbuf: lower casing it, separating words
	// and counting them too
	char *s = dictbuf;
	int nwords = 1;
	for( int i=0; i<size; i++ )
	{
		*s = tolower(*s);
		if( *s == '\n' )
		{
			*s = '\0';
			nwords++;
		}
		s++;
	}

	printf( "debug: Found %d words\n", nwords );
	//exit(1);

	char **abecedword = malloc( nwords * sizeof(char *) );
	assert( abecedword != NULL );

	// Select only those words which are abeced..
	char *src = dictbuf;
	char *dst = abecbuf;
	int nsel = 0;
	for( int w=0; w<nwords; w++ )
	{
		//printf( "debug: word %d=%s\n", w, src );
		int len = strlen(src);
		if( is_abeced(src) )
		{
			printf( "debug: abeced word %d=%s\n", nsel, src );
			abecedword[nsel] = dst;
			strcpy( dst, src );
			dst += len+1;
			nsel++;
		}
		src += len+1;
	}

	printf( "debug: Found %d Abecedarian words\n", nsel );
	//exit(1);

	// sort selected word array in descending order of length
	qsort( abecedword, nsel, sizeof(char *), &compareword );

	// display the Abecedarian words
	for( int i=0; i<nsel; i++ )
	{
		printf( "%s\n", abecedword[i] );
	}

	return 0;
}
