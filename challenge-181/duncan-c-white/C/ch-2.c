//
// Task 2: Hot Day
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
#include "readline.h"
#include "trim.h"


#define MAXDATESTRLEN 12
typedef struct {
	char datestr[MAXDATESTRLEN];	// an ISO date str
	int  temp;			// associated temperature
} datetemp;


//
// datetemp dt;
// bool ok = split_dt( str, &dt );
//	Split a string (str) into a datestring and temp,
//	storing the results in dt, and returning true if
//	splitting is successful; or return false if it fails.
//
bool split_dt( char *str, datetemp *dt )
{
	char *comma = strchr( str, ',' );
	if( comma == NULL ) return false;
	*comma = '\0';
	if( strlen(str) > MAXDATESTRLEN ) return false;
	strcpy( dt->datestr, str );

	for( str = comma+1; isspace(*str); str++ ) /*EMPTY*/;

	if( ! isdigit(*str) ) return false;
	dt->temp = atoi( str );

	return true;
}


#define MAXLINES 100000
datetemp dt[MAXLINES];
int nlines;


static int comparedts( const void *a, const void *b)
{
	datetemp *da = (datetemp *) a;
	datetemp *db = (datetemp *) b;
	return strcmp(da->datestr, db->datestr);
}

int main( int argc, char **argv )
{
	(void)process_flag_n_args( "hot-day", argc, argv,
		0, "[reads stdin]" );

	char line[40];

	for( nlines = 0; readline_discardrest( stdin, line, 40 ); nlines++ )
	{
		assert( nlines < MAXLINES );
		trim( line );
		if( debug )
		{
			printf( "read line '%s'\n", line );
		}
		if( ! split_dt( line, &dt[nlines] ) )
		{
			fprintf( stderr, "hot-day: can't parse '%s' as "
					 "date, temp\n", line );
			exit(1);
		}
		if( debug )
		{
			printf( "line '%s' split into date %s, temp %d\n",
				line, dt[nlines].datestr, dt[nlines].temp );
		}
	}
	if( debug )
	{
		printf( "%d lines\n", nlines );
	}

	// now sort them
	qsort( dt, nlines, sizeof(datetemp), &comparedts );

	// now find all dates D for which the temperature
	// on date D is hotter than on D-1.
	for( int pos=1; pos<nlines; pos++ )
	{
		datetemp *today = &dt[pos];
		datetemp *yest = &dt[pos-1];
		if( debug )
		{
			printf( "processing date %s, yest %s, today temp %d, "
				"yest temp %d\n", today->datestr,
				yest->datestr, today->temp, yest->temp );
		}
		if( yest->temp < today->temp )
		{
			printf( "%s\n", today->datestr );
		}
	}

	return 0;
}
