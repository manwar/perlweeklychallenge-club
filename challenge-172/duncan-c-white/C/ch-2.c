/* 
 * Task 2 - Five-number Summary
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-2.pl.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>
#include <ctype.h>

#include "args.h"


//
// double med = median( arr[], nel );
//	Calculate the median value in the sorted array arr[0..nel-1].
//
double median( int *arr, int nel )
{
	int midpos = nel/2;
	double median = nel%2 == 0 ?
		(arr[midpos-1]+arr[midpos])/2.0 :
		arr[midpos];
	return median;
}


int intcompare( const void *p1, const void *p2 )
{
	// The actual arguments to this function are "pointers to
	// pointers to char", but strcmp(3) arguments are "pointers
	// to char", hence the following cast plus dereference */

	int a = *((int *)p1);
	int b = *((int *)p2);
	return a - b;
}


void prarr( int *arr, int nel )
{
	for( int i=0; i<nel; i++ )
	{
		printf( "%d, ", arr[i] );
	}
	putchar('\n');
}


#define MAXDATA 100

int main( int argc, char **argv )
{
	int arr[MAXDATA];
	int nel = process_listnumargs( "five-number-summary",
		argc, argv, arr, MAXDATA );

	// sort arr[0..nel-1] numerically
	qsort( arr, nel, sizeof(int), &intcompare );

	if( debug )
	{
		printf( "debug: sorted " );
		prarr( arr, nel );
	}

	double medn = median( arr, nel );

	int midpos = nel/2;
	if( debug )
	{
		printf( "debug: median=%.2f, midpos=%d\n", medn, midpos );
	}

	// h1: first half of arr[]
	int h1nel = midpos;
	int *h1 = arr;

	// h2: second half of arr[]
	if( nel%2 != 0 ) midpos++;
	int *h2 = arr+midpos;
	int h2nel = nel-midpos;

	if( debug )
	{
		printf( "debug: h1 = " );
		prarr( h1, h1nel );
		printf( "debug: h2 = " );
		prarr( h2, h2nel );
	}

	double firstq = median( h1, h1nel );
	double thirdq = median( h2, h2nel );

	double min = arr[0];
	double max = arr[nel-1];

	printf( "   %5.1f\n", medn );
	printf( "%5.1f  %5.1f\n", firstq, thirdq );
	printf( "%5.1f  %5.1f\n", min, max );

	return 0;
}
