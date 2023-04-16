//
// Task 2: Split Same Average
// 
// C version.
// 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <math.h>

#include "args.h"
#include "parseints.h"
#include "printarray.h"


#define EPSILON 0.00001


//
// void subset_select( comb, nval, val[], &nsel, sel[], &nnotsel, notsel[] );
//	Consider comb as an nsel-bit binary unsigned number.
//	Select all the values from val[] whose corresponding bit in comb is 1,
//	store them into sel[nsel] (setting nsel), and store all the unselected
//	values into notsel[nnotsel], setting nnotsel.
//
void subset_select( int comb, int nval, int *val, int *nsel, int *sel, int *nnotsel, int *notsel )
{
	*nsel = *nnotsel = 0;
	for( int i=0; i<nval; i++ )
	{
		int v = val[i];
		if( comb%2 == 1 )
		{
			sel[(*nsel)++] = v;
		} else
		{
			notsel[(*nnotsel)++] = v;
		}
		comb >>= 1;
	}
}


//
// bool found = count_val_avg( goalavg, nval, val[], &nsel, sel[], &nnotsel, notsel[] );
//	Attempt to find a subset of val[nval] whose average is goalavg.
//	If we find one, copy the number of subset elements into nsel,
//      and all subset elements into sel[nsel], and all other elements into
//	notsel[], setting notnsel to nval - nsel, and return true.
//	If we can't find one, return false.
//	Do it by iterating over all D-bit binary numbers from 1..2**nval-2
//	subset-summing each selected combination
//
bool count_val_avg( double goalavg, int nval, int *val, int *nsel, int *sel, int *nnotsel, int *notsel )
{
	// d = 2**nval - 2
	int d = 1;
	for( int i=0; i<nval; i++ ) d *= 2;
	d -= 2;

	if( debug )
	{
		printf( "debug: nval = %d, d = %d\n", nval, d );
	}

	for( int comb=1; comb<=d; comb++ )
	{
		*nsel = 0;
		*nnotsel = 0;
		subset_select( comb, nval, val, nsel, sel, nnotsel, notsel );
		if( debug )
		{
			printf( "debug: selecting comb=%d, nsel=%d, "
				"nnotsel=%d, selected = ",
				comb, *nsel, *nnotsel );
			print_int_array( 60, *nsel, sel, ',', stdout );
		}

		if( *nsel == 0 )
		{
			if( debug ) printf( " : rejected\n" );
			continue;
		}

		int sum = 0;
		for( int i=0; i<*nsel; i++ )
		{
			sum += sel[i];
		}
		double avg = ((double)sum) / *nsel;
		if( debug )
		{
			//printf( ", not selected = " );
			//print_int_array( 60, *nnotsel, notsel, ',', stdout );
			printf( ", sum=%d, avg=%g\n", sum, avg );
		}
		if( fabs(avg-goalavg) < EPSILON )
		{
			#if 0
			printf( "debug: returning true, fabs(a-ga)=%g\n",
				fabs(avg-goalavg) );
			#endif

			return true;
		}
	}
	return false;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "split-sum-average", argc, argv,
		1, 1000, "intlist" );
	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( debug )
	{
		printf( "debug: list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	int sel[nel];
	int notsel[nel];
	int nsel = 0;
	int nnotsel = 0;

	int sum = 0;
	for( int i=0; i<nel; i++ )
	{
		sum += list[i];
	}
	double goalavg = ((double)sum)/nel;
	if( debug )
	{
		printf( "debug: goal average is %g\n", goalavg );
	}


	bool found = count_val_avg( goalavg, nel, list,
				    &nsel, sel, &nnotsel, notsel );
	if( found )
	{
		if( debug )
		{
			printf( "debug: found selected " );
			print_int_array( 60, nsel, sel, ',', stdout );
			printf( " and not selected " );
			print_int_array( 60, nnotsel, notsel, ',', stdout );
			putchar( '\n' );
		}
		printf( "true\n" );
	} else
	{
		if( debug )
		{
			printf( "debug: no subsets found\n" );
		}
		printf( "false\n" );
	}
	return 0;
}
