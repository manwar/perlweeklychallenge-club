/* 
 * TASK #2 - Summations
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-2.pl.
 */ 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>
#include <unistd.h>
#include <ctype.h>




bool debug=false;


// process_args( argc, argv, &nel, &v );
//	Process the -d flag, set nel to the number of
//	remaining arguments, check that all those
//	remaining arguments are +ve numbers, copy remaining
//	args to a new integer dynamic array v.
void process_args( int argc, char **argv, int *nel, int **v )
{
	int arg=1;
	if( argc>1 && strcmp( argv[arg], "-d" ) == 0 )
	{
		debug++;
		arg++;
	}

	*nel = argc-arg;
	if( *nel < 2 )
	{
		fprintf( stderr,
			"Usage: summations [-d] list of +ve numbers\n" );
		exit(1);
	}

	int lastpos = argc-1;

	// elements are in argv[arg..lastpos], copy them to new int v[] array

	// allocate the array
	*v = malloc( *nel * sizeof(int) );
	assert( *v != NULL );

	if( debug )
	{
		printf( "debug: arg=%d, lastpos=%d, nel=%d\n",
			arg, lastpos, *nel );
	}

	// check that all remaining arguments are +ve integers,
	// and then copy them to v[]
	for( int i=arg; i<=lastpos; i++ )
	{
		if( ! isdigit(argv[i][0]) )
		{
			fprintf( stderr,
			 "sum-bitwise-pairs: arg %d (%s) is not a +ve number\n",
			 i, argv[i] );
			exit(1);
		}
		(*v)[i-arg] = atoi( argv[i] );
		//printf( "debug: v[%d] = %d\n", i-arg, (*v)[i-arg] );
	}
}


int main( int argc, char **argv )
{
	int nel;
	int *v;
	process_args( argc, argv, &nel, &v );

	int r = 1;
	if( debug )
	{
		printf( "row %d:", r );
		for( int i=0; i<nel; i++ )
		{
			printf( " %d", v[i] );
		}
		putchar( '\n' );
	}
	while( nel > 1 )
	{
		// shift v array down
		for( int i=0; i<nel; i++ )
		{
			v[i] = v[i+1];
		}
		v[nel-1] = -1;
		nel--;

		for( int pos = 1; pos<nel; pos++ )
		{
			v[pos] += v[pos-1];
		}
		r++;

		if( debug )
		{
			printf( "row %d:", r );
			for( int i=0; i<nel; i++ )
			{
				printf( " %d", v[i] );
			}
			putchar( '\n' );
		}
	}
	printf( "%d\n", v[0] );

	free( v );
}
