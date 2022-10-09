//
// Task 1: MAC Address
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
// bool isvalid = validate( arg, template );
//	validate the argument against a template (a string of 'W's and '.'s)
//	return true iff the argument is valid.
//
bool validate( char *arg, char *template )
{
	int len = strlen(arg);
	if( len != strlen(template) )
	{
		return false;
	}
	for( int i=0; i<len; i++ )
	{
		char t = template[i];
		if( t == 'W' )
		{
			if(debug)
			{
				printf( "debug: W %c\n", arg[i] );
			}
			if( ! isalnum(arg[i]) )
			{
				return false;
			}
		} else
		{
			if(debug)
			{
				printf( "debug: %c %c\n", t, arg[i] );
			}
			if( arg[i] != t )
			{
				return false;
			}
		}
	}
	return true;
}


//
// reformat( arg, mac );
//	reformat arg (14 digit, 3 groups of 4 hex digits sep by '.'s)
//	as a normal mac address, storing it into mac.
void reformat( char *arg, char *mac )
{
	mac[0] = arg[0];
	mac[1] = arg[1];
	mac[2] = ':';
	mac[3] = arg[2];
	mac[4] = arg[3];
	mac[5] = ':';
	mac[6] = arg[5];
	mac[7] = arg[6];
	mac[8] = ':';
	mac[9] = arg[7];
	mac[10] = arg[8];
	mac[11] = ':';
	mac[12] = arg[10];
	mac[13] = arg[11];
	mac[14] = ':';
	mac[15] = arg[12];
	mac[16] = arg[13];
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "mac-address", argc, argv,
		1, "macaddr eg. abc1.20f1.345a" );

	if( debug )
	{
		printf( "debug: argno=%d, arg=%s\n", argno, argv[argno] );
	}

	if( ! validate( argv[argno], "WWWW.WWWW.WWWW" ) )
	{
		fprintf( stderr, "mac-address: bad format %s\n", argv[argno] );
		exit(1);
	}
	char mac[100];
	reformat( argv[argno], mac );


	printf( "%s\n", mac );

	return 0;
}
