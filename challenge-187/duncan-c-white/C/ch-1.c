//
// Task 1: Days Together
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
//#include "parseints.h"
//#include "printarray.h"


int dim[] = { -1, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

// int day_in_year = yearday( ddmm );
//     Check whether $ddmm is a valid date of format dd-mm where dd is 1..31
//	and mm is 1..12 (and dd <= days_in_month(mm)), returning the day number
//	in the year if it is, or -1 if it is invalid.
//
int yearday( char *ddmm )
{
	// validate overall shape /^(\d\d?)-(\d\d?)$/
	int d, m;
	if( sscanf( ddmm, "%d-%d", &d, &m ) != 2 ) return -1;

	if( m < 1 || m > 12 ) return -1;

	if( d < 1 || d > dim[m] ) return -1;

	int dayno = 0;
	for( int i=1; i<m; i++ )
	{
		dayno += dim[i];
	}
	dayno += d;
	return dayno;
}


#define min(a,b)  ((a)<(b)?(a):(b))
#define max(a,b)  ((a)>(b)?(a):(b))


//
//
// int noverlap = overlapdays( sd1d, ed1d, sd2d, ed2d );
//	Find out the number of overlapping days between the two ranges
//	of dates, as the task describes.  Each date is represented by
//	a logical day-number-in-the-year.  Return 0 if no overlap.
int overlapdays( int sd1d, int ed1d, int sd2d, int ed2d )
{
	// none if one range finishes before the other
	if( ed1d < sd2d || ed2d < sd1d ) return 0;

	int csd = max(sd1d,sd2d); // common start date
	int ced = min(ed1d,ed2d); // common end date

	return 1+ced-csd;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "overlapping-days", argc, argv,
		4, "dd-mm-sd1 dd-mm-ed1 dd-mm-sd2 dd-mm-ed2" );

	if( debug )
	{
		printf( "debug: argno=%d, firstarg=%s\n", argno, argv[argno] );
	}

	char *date = argv[argno++];
	int sd1d = yearday( date ); // days since start of year for sd1
	if( sd1d < 1 )
	{
		fprintf( stderr, "Bad dd-mm-sd1 (%s)\n", date );
		exit(1);
	}

	date = argv[argno++];
	int ed1d = yearday( date ); // days since start of year for ed1
	if( ed1d < 1 )
	{
		fprintf( stderr, "Bad dd-mm-ed1 (%s)\n", date );
		exit(1);
	}

	date = argv[argno++];
	int sd2d = yearday( date ); // days since start of year for sd2
	if( sd2d < 1 )
	{
		fprintf( stderr, "Bad dd-mm-sd2 (%s)\n", date );
		exit(1);
	}

	date = argv[argno++];
	int ed2d = yearday( date ); // days since start of year for ed2
	if( ed2d < 1 )
	{
		fprintf( stderr, "Bad dd-mm-ed2 (%s)\n", date );
		exit(1);
	}

	printf( "sd1:%d, ed1:%d, sd2:%d, ed2:%d\n", sd1d, ed1d, sd2d, ed2d );

	int noverlap = overlapdays( sd1d, ed1d, sd2d, ed2d );
	printf( "%d days\n", noverlap );

	return 0;
}
