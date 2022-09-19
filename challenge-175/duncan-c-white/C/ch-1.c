/* 
 * Task 1 - Last Sunday
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-1.pl.
 */ 

//#define _XOPEN_SOURCE

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
//#include <assert.h>
#include <time.h>

#include "args.h"


// seconds in a day
#define SECSINDAY (24*60*60)


//
// time_t t = ymd( y, m, d );
//	Return the abolute time (seconds since Jan 1st 1970 corresponding
//	to the date y-m-d.
//
time_t ymd( int y, int m, int d )
{
	struct tm info;
	info.tm_year = y - 1900;
	info.tm_mon = m - 1;
	info.tm_mday = d;
	info.tm_hour = 0;
	info.tm_min = 0;
	info.tm_sec = 1;
	info.tm_isdst = -1;
	time_t t = mktime( &info );
	if( t == -1 ) {
		printf("Error: unable to make time using mktime\n");
	} else {
		char buffer[80];
		strftime(buffer, sizeof(buffer), "%c", &info );
		//printf("debug: %s\n", buffer);
	}
	return t;
}


int main( int argc, char **argv )
{
	int y;
	process_onenumarg( "last-sunday", argc, argv, &y );

	for( int m=1; m<=12; m++ )
	{
		char sunday[20];
		for( time_t t = ymd( y, m, 1 ); ; t += SECSINDAY )
		{
			struct tm *day = localtime(&t);
			if( debug )
			{
				char datestr[40];
				strcpy( datestr, asctime(day) );
				datestr[strlen(datestr)-1] = '\0';
				printf( "%lu, %s: tm_mon=%d, tm_day=%d, tm_wday=%d\n",
					t, datestr, day->tm_mon,
					day->tm_mday, day->tm_wday );
			}
		if( day->tm_mon != m-1 ) break;
			if( day->tm_wday == 0 )
			{
				strftime( sunday, 20, "%Y-%m-%d", day );
				if( debug )
				{
					printf( "found a sunday: %s\n", sunday );
				}
			}
		}
		printf( "%s\n", sunday );
	}
	return 0;
}
