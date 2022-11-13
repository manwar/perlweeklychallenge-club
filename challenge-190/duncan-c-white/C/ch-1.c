//
// Task 1: Capital Detection
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
// bool ok = capdetect( str );
//	Return true iff str is a good "use of capitals" string as described
//	above, or return false otherwise.
//
bool capdetect( char *str )
{
	if( isupper(*str) )
	{
		bool alllower = true;
		bool allupper = true;
		for( char *p=str+1; *p; p++ )
		{
			if( ! islower(*p) ) alllower = false;
			if( ! isupper(*p) ) allupper = false;
		}
		if( alllower || allupper ) return true;
	}
	if( islower(*str) )
	{
		bool alllower = true;
		for( char *p=str+1; *p; p++ )
		{
			if( ! islower(*p) ) alllower = false;
		}
		if( alllower ) return true;
	}
	return 0;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "capital-detect", argc, argv,
		1, "string" );

	char *str = argv[argno++];

	if( debug )
	{
		printf( "debug: str=%s\n", str );
	}

	bool ok = capdetect( str );

	printf( "%c\n", ok?'1':'0' );

	return 0;
}
