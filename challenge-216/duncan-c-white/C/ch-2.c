// Task 2: Word Stickers
//
// C translation

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>

#include "args.h"


//
// bool ismissing = lettermissing( letter, sticker[], nstickers );
//	Return true iff letter is missing from all sticker[nstickers].
//	Return false otherwise.
//
bool lettermissing( char letter, char **sticker, int nstickers )
{
  for( int i=0; i<nstickers; i++ ) {
    if( strchr( sticker[i], letter ) != NULL ) return false;
  }
  return true;
}


//
// findmissing( word, sticker[], nstickers, missing[] );
//	Find all the letters that are in word
//	but which are missing from all sticker[nstickers],
//	and copy the missing letters into missing[] as a NUL-terminated
//	C string.  missing[] is empty ("") if no letters are missing.
//	Assume that missing[] is big enough to store (potentially) all
//	letters in the word.
//
void findmissing( char *word, char **sticker, int nstickers, char *missing ) {
  char *mp = missing;
  *mp = '\0';
  for( char *wp=word; *wp; wp++ ) { // foreach letter *wp in word
    char letter = *wp;
    if( lettermissing(letter,sticker,nstickers) )
    {
      *mp++ = letter;
      *mp = '\0';
      if( debug ) {
        printf( "debug: found missing letter '%c'\n", letter );
      }
    }
  }
}


//
// lettersincommon( word, sticker, incommon );
//	Find all the letters that word has in common with sticker
//	(using each letter in sticker only once), and form them
//	into a NUL-terminated C string in incommon[].
//	Assume that incommon[] is big enough to store (potentially) all
//	letters in the word.
//
void lettersincommon( char *word, char *sticker, char *incommon ) {
  char *cp = incommon;
  *cp = '\0';
  int wlen = strlen(word);
  char wcopy[wlen+1];
  strcpy( wcopy, word );
  for( char *s=sticker; *s; s++ ) {
    char letter = *s;
    char *found = strchr( wcopy, letter );
    if( found != NULL ) {
      memmove( found, found+1, wlen-(found-wcopy) );	// delete *found from wcopy
      *cp++ = letter;
      *cp = '\0';
    }
  }
}


int nstickers;		// how many stickers there are
char **stickers;	// stickers[nstickers]: list of sticker words


//
// print_stickers( n, which );
//	Print a comma-separated list of stickers given which[n],
//	an array of sticker NUMBERS to print.
//
void print_stickers( int n, int *used ) {
  for( int i=0; i<n; i++ ) {
    if( i>0 ) putchar( ',' );
    printf( "%s", stickers[used[i]] );
  }
  putchar( '\n' );
}


int minstickers=1000000;
int minstickers_used[1024];


//
// findall( word, used );
//	Given a word, and a numbered list of stickers already used in
//	used[0..] (ended by a -1 sentinel),
//	find all combinations of stickers[nstickers] that contain all letters
//	in word, and track and store the best (minimum) number of stickers
//	in minstickers, along with the sticker numbers themselves in
//	minstickers_used[].
//	How? the key insight is that each sticker can be used (or not)
//	whenever it contains any letters in common with the word.  So try
//	both possibilities recursively.
//
void findall( char *word, int *used ) {
  // count how many stickers we've currently used
  int nused;
  for( nused=0; used[nused] != -1; nused++ );

  if( *word == '\0' ) {
    if( debug ) {
      printf( "debug: found solution, used = " );
      print_stickers( nused, used );
    }
    if( nused < minstickers )
    {
      minstickers = nused;
      memcpy( minstickers_used, used, nused*sizeof(int) );
      if( debug ) {
        printf( "debug: found new best solution, min stickers = %d, used = ",
		minstickers );
	print_stickers( minstickers, minstickers_used );
      }
    }
    return;
  }

  for( int sn=0; sn<nstickers; sn++ ) {		// foreach sticker
    char *sticker = stickers[sn];

    char incommon[52];
    lettersincommon( word, sticker, incommon );
    if( *incommon == '\0' ) continue;

    //if( debug ) {
    //  printf( "debug: letters in common between %s and %s are %s\n",
    //  word, sticker, incommon );
    //}

    // there are two possibilities: use this sticker or don't;
    // try both..

    // try using the sticker
    if( debug ) {
      printf( "debug: USING sticker %s, against %s, letters in common %s\n",
        sticker, word, incommon );
    }
    used[nused++] = sn;
    used[nused] = -1;

    char *newword = strdup(word);
    for( char *s=incommon; *s; s++ ) {
      // remove first instance of each incommon letter from newword
      char *found = strchr( newword, *s );
      assert( found != NULL );
      int len = strlen(newword);
      memmove( found, found+1, len-(found-newword) );
    }
    if( debug ) {
      printf( "debug: after removing common letters, new word is <%s>\n",
        newword );
    }
    findall( newword, used );
    free( newword );

    // now try without the sticker
    used[--nused] = -1;
  }
}


int main( int argc, char **argv )
{
  int argno = process_flag_n_m_args( "word-stickers", argc, argv,
                            2, 1000, "word stickerwordlist" );

  // lower case all arguments
  for( int i=argno; i<argc; i++ ) {
    for( char *s=argv[i]; *s; s++ ) *s = tolower(*s);
  }

  char *word = argv[argno++];

  stickers = argv+argno;
  nstickers = argc-argno;

  if( debug ) {
    printf( "debug: word: %s, list: ", word );
    for( int i=0; i<nstickers; i++ ) {
      if( i>0 ) putchar( ',' );
      printf( "%s", stickers[i] );
    }
    putchar( '\n' );
  }

  char missingletters[512];
  findmissing( word, stickers, nstickers, missingletters );
  if( *missingletters != '\0' ) {
    printf( "0\n" );
    if( debug ) {
      printf( "No solutions, because letters %s "
	      "are missing from all stickers\n", missingletters );
    }
    exit(0);
  }

  char incommon[52];
  lettersincommon( word, stickers[0], incommon );
  if( debug ) {
    printf( "debug: letters in common between %s and %s are %s\n",
  	word, stickers[0], incommon );
  }

  minstickers=1000000;
  minstickers_used[0] = -1;

  int stickers_used[1024];
  stickers_used[0] = -1;

  findall( word, stickers_used );

  printf( "%d\n", minstickers );
  if( debug ) {
    printf( "debug: stickers used: " );
    print_stickers( minstickers, minstickers_used );
  }
  return 0;
}
