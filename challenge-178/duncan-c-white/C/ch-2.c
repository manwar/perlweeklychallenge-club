//
// Task 2: Business Date
// 
// C version.
// 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>

#define __USE_XOPEN
#include <time.h>

#include "args.h"


#define STARTHOUR 9
#define ENDHOUR   18
// experimented with much shorter day: #define STARTHOUR 14
// experimented with much shorter day: #define ENDHOUR   17

#define DAYLEN (ENDHOUR - STARTHOUR)


//
// bool ok = is_business_day_and_time( date );
//	Given a date object date, return 1 iff date is a business day
//	and within business hours, else return 0.
//
bool is_business_day_and_time( struct tm date )
{
	int dow = date.tm_wday;
	if( debug )
	{
		printf( "debug ibdt: dow=%d\n", dow );
	}
	if( dow<1 || dow>5 ) return false;

	int h = date.tm_hour;
	int m = date.tm_min;
	if( debug )
	{
		printf( "debug ibdt: h=%d, m=%d\n", h, m );
	}
	if( h >= STARTHOUR && h < ENDHOUR ) return true;
	if( h == ENDHOUR && m == 0 ) return true;
	return false;
}


//
// double rem = remainder_of_business_day( h, m );
//	Given a time (hour h, minute m) that is within working hours,
//	return the (real) number of hours remaining in that business day.
//
double remainder_of_business_day( int h, int m )
{
	double t = h + ((double)m) / 60;
	return ENDHOUR - t;
}


//
// next_business_day( &date );
//	Move date to the next business day.
//
void next_business_day( struct tm *date )
{

	int dow = date->tm_wday;
	if( debug )
	{
		printf( "debug nbd: dow=%d\n", dow );
	}

	do
	{
		// move to next physical day
		date->tm_mday++;
		date->tm_isdst = -1;
		mktime( date );
		//dow = date->tm_wday;
		dow++;
		if( dow==7 ) dow = 0;
	} while( dow < 1 || dow > 5 );
	if( debug )
	{
		char buf[255];
		strftime( buf, sizeof(buf), "%a %d %b %Y %H:%M", date );
		printf( "debug nbd: nbd=%s\n", buf );
	}
}


//
// add_business_duration( &date, duration );
//	Add a +ve duration duration (real, business hours) to the given date,
//	modifying the resultant date.  This must skip from ENDHOUR:00 to
//	STARTHOUR:00 on the next business day, where necessary.
//
void add_business_duration( struct tm *date, double duration )
{
	int h = date->tm_hour;
	int m = date->tm_min;
	if( debug )
	{
		printf( "debug abd: h=%d, m=%d\n", h, m );
	}

	double rem = remainder_of_business_day( h, m );
	if( debug )
	{
		printf( "debug abd: remainder of busday: %g hours\n", rem );
	}

	if( duration <= rem )
	{
		int id = duration;
		int md = (int)((duration-(double)id)*60.0);
		if( debug )
		{
			printf( "debug abd: duration=%g, id=%d, md=%d\n",
				duration, id, md );
		}

		h += id;
		m += md;
		if( m > 60 )
		{
			m -= 60;
			h++;
		}
		date->tm_hour = h;
		date->tm_min = m;
	} else
	{
		// duration goes onto another day; move to end of the day
		duration -= rem;

		int id = duration;
		int md = (int)((duration-(double)id)*60.0);
		if( debug )
		{
			printf( "debug abd: remaining duration=%g, id=%d, md=%d\n",
				duration, id, md );
		}

		// now advance date to next business day
		next_business_day( date );

		// now advance business days while id>=daylen
		while( id >= DAYLEN )
		{
			next_business_day( date );
			id -= DAYLEN;
		}

		int y = date->tm_year;
		int mon = date->tm_mon;
		int d = date->tm_mday;
		if( debug )
		{
			printf( "debug abd: next business day y=%d, m=%d, "
			    "d=%d, duration=%g, id=%d, md=%d\n", y, mon, d,
			    duration, id, md );
		}

		h = date->tm_hour = STARTHOUR + id;
		m = date->tm_min = md;
		if( debug )
		{
			printf( "debug abd: time = %02d:%02d\n", h, m );
		}
	}
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "business-date", argc, argv,
			2, "datetime duration" );
	char *dt = argv[argno++];
	char *duration = argv[argno];

	struct tm datetime;
	memset( &datetime, 0, sizeof(struct tm) );
	datetime.tm_min = -1;
	char *result = strptime( dt, "%Y-%m-%d %H:%M", &datetime );
	if( datetime.tm_min == -1 || (result != NULL && *result != '\0') )
	{
		fprintf( stderr, "business-date: can't parse datetime %s\n", dt );
		exit(1);
	}
	if( ! is_business_day_and_time( datetime ) )
	{
		fprintf( stderr, "business-date: date %s - is "
				 "not a business day/time\n", dt );
		exit(1);
	}

	char buf[255];

	#if 0
	strftime( buf, sizeof(buf), "%a %d %b %Y %H:%M", &datetime );
	printf( "validated date/time: %s\n", buf);
	#endif

	double dur;
	if( ! check_unsigned_real( duration, &dur ) )
	{
		fprintf( stderr, "business-date: can't parse duration %s\n",
			duration );
		exit(1);
	}
	#if 0
	printf( "duration: %g hours\n", dur );
	#endif

	#if 0
	int h = datetime.tm_hour;
	int m = datetime.tm_min;
	double rem = remainder_of_business_day( h, m );
	printf( "remainder of busday: %g hours\n", rem );
	#endif

	#if 0
	next_business_day( &datetime );
	strftime( buf, sizeof(buf), "%a %d %b %Y %H:%M", &datetime );
	printf( "next bus day date/time: %s\n", buf);
	#endif

	if( dur > 0 )
	{
		dur += 0.01;	// fuzz factor to make rounding work better:-)
		add_business_duration( &datetime, dur );
	}
	strftime( buf, sizeof(buf), "%a %d %b %Y %H:%M", &datetime );
	printf( "final bus day date/time: %s\n", buf);

	return 0;
}
