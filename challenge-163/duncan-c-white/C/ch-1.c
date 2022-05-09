/* 
 * TASK #1 - Sum Bitwise Operator
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-1a.pl.
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
			"Usage: sum-bitwise-pairs [-d] list of +ve numbers\n" );
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

	int sum = 0;
	for( int i=0; i<nel-1; i++ )
	{
		for( int j=i+1; j<nel; j++ )
		{
			int a = v[i];
			int b = v[j];
			if( debug )
			{
				printf( "debug: i=%d, j=%d, a=%d, b=%d, a&b=%d\n",
					i, j, a, b, a&b );
			}
			sum += (a & b);
		}
	}

	printf( "%d\n", sum );

	free( v );
}
