//
// Task 1: Shortest Time
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
// int time = parsehhmm( hhmm );
//	Parse a 24-hour hh:mm time string into the total number
//	of minutes since 00:00, and return it.
//
int parsehhmm( char *hhmm )
{
	if( strlen(hhmm) != 5 )
	{
		fprintf( stderr, "parsehhmm: bad length %s\n", hhmm );
		exit(1);
	}
	if( ! isdigit(hhmm[0]) || ! isdigit(hhmm[1]) || hhmm[2] != ':'
	||  ! isdigit(hhmm[3]) || ! isdigit(hhmm[4]) )
	{
		fprintf( stderr, "parsehhmm: bad format %s\n", hhmm );
		exit(1);
	}
	return 60*atoi(hhmm) + atoi(hhmm+3);
}


int intcompare( const void *ap, const void *bp )
{
	int a = *((int *)ap);
	int b = *((int *)bp);
	return a-b;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "shortest-time", argc, argv,
		1, 1000, "hh:mm list" );

	int nel = argc-argno;
	int time[nel+1];

	if( debug )
	{
		printf( "debug: initial list: nel=%d, ", nel );
		for( int i=argno; i<argc; i++ )
		{
			if( i>argno ) putchar(',');
			printf( "%s", argv[i] );
		}
		putchar( '\n' );
	}

	for( int i=argno; i<argc; i++ )
	{
		time[i-argno] = parsehhmm( argv[i] );
	}

	if( debug )
	{
		printf( "debug: times are: " );
		for( int i=0; i<nel; i++ )
		{
			if( i>0 ) putchar(',');
			printf( "%d", time[i] );
		}
		putchar( '\n' );
	}

	qsort( time, nel, sizeof(int), &intcompare );

	time[nel] = 1440+time[0];

	if( debug )
	{
		printf( "debug: sorted times are: " );
		for( int i=0; i<=nel; i++ )
		{
			if( i>0 ) putchar(',');
			printf( "%d", time[i] );
		}
		putchar( '\n' );
	}

	int best   = 1440;
	int bestt1 = -1;
	int bestt2 = -1;

	for( int pos=0; pos<nel; pos++ )
	{
		int t = time[pos+1];
		int diff = t - time[pos];
		if( debug )
		{
			printf( "debug: pos %d, diff %d\n", pos, diff );
		}
		if( best > diff )
		{
			best = diff;
			bestt1 = time[pos];
			bestt2 = t;
		}
	}

	printf( "%d\n", best );

	if( debug )
	{
		char sbestt1[10];
		char sbestt2[10];
		sprintf( sbestt1, "%02d:%02d", bestt1/60, bestt1%60 );
		sprintf( sbestt2, "%02d:%02d", bestt2/60, bestt2%60 );
		printf( "(%s..%s)\n", sbestt1, sbestt2 );
	}

	return 0;
}
