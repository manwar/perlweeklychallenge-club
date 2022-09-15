#include <ctype.h>
#include <stdio.h>
#include <string.h>


//
// trim( str );
//	given a writable string (str), modify it to remove any leading
//      or trailing whitespace.
//
void trim( char *str )
{
	int len = strlen(str);
	if( isspace( str[len-2] ) )
	{
		char *s;
		for( s = str+len-2; s>str && isspace(*s); s-- ) /*EMPTY*/ ;
		s++;
		*s = '\0';		// chop off trailing whitespace
	}

	if( isspace(*str) )
	{
		char *s;
		for( s = str; isspace(*s); s++ ) /*EMPTY*/ ;
		for( char *d = str; (*d = *s ) != '\0'; s++, d++ ) /*EMPTY*/ ;
	}
}
