//
// Task 2: Rearrange Groups (into sequences)
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


// qsort comparator for int elements
int intcompare( const void *a, const void *b )
{
	int *ai = (int *)a;
	int *bi = (int *)b;
	return *ai - *bi;
}


//
// int p = posisin( v, slist, spos, epos );
//	Attempt to find (the first instance of) v in slist[spos..epos].  If
//	we find it, return the position of the first v. If not, return -1.
//
int posisin( int v, int *slist, int spos, int epos )
{
	for( int i=spos; i<=epos; i++ )
	{
		if( slist[i] == v ) return i;
	}
	return -1;
}


//
// bool found = find_seq_at( nel, slist[], spos, size, pos[] );
//	Find a single size-element sequence X, X+1, X+2.. X+size-1 starting
//	at spos. If such a sequence can be found, store the slist[i] index
//	positions in pos[size] and return true, otherwise return false.
//
bool find_seq_at( int nel, int *slist, int spos, int size, int *pos )
{
	pos[0] = spos;
	int wantval = slist[spos];
	for( int i=1; i<size; i++ )
	{
		spos++; wantval++;
		// fail unless wantval is present
		int p = posisin( wantval, slist, spos, nel-1 );
		if( p == -1 ) return false;
		pos[i] = p;
	}
	return true;
}


//
// bool found = find_isolated_seq_posns( size, slist, nel, pos );
//	Find a single size-element long sequence X, X+1, X+2.. X+size-1
//	in slist[nel] (where X-1 is not present).  If such a sequence
//	can be found, store the slist[i] index positions in pos[size]
//	and return true, otherwise return false.
//	
bool find_isolated_seq_posns( int size, int *slist, int nel, int *pos )
{
	// foreach distinct value in slist[nel]
	for( int i=0; i<nel; i++ )
	{
		// distinct (x must not be present before)
		if( i>0 && posisin( slist[i], slist, 0, i-1 ) >= 0 )
		{
			continue;
		}
		// x-1 must not be present
		if( i>0 && posisin( slist[i]-1, slist, 0, i-1 ) >= 0 )
		{
			continue;
		}
		#if 0
		if( debug )
		{
			printf( "debug: found distinct value %d at pos %d\n",
				slist[i], i );
		}
		#endif
		if( find_seq_at( nel, slist, i, size, pos ) )
		{
			return true;
		}
	}
	return false;
}



//
// reorder( nel, slist, size, pos );
//	Given slist[0..nel-1] and a sequence found at pos[0..size-1],
//	reorder the slist so that the sequence is at the front.
//
void reorder( int nel, int *slist, int size, int *pos )
{
	for( int i=0; i<size; i++ )
	{
		int p = pos[i];
		// reorder slist[] so that slist[p] is moved to slist[i]
		// and slist[i..p-1] are moved up one position
		if( p != i )
		{
			int v = slist[p];

			// move slist[i..p-1] up one
			for( int j=p-1;j>=i; j-- )
			{
				slist[j+1] = slist[j];
			}
			slist[i] = v;
		}
	}
}


//
// bool done = find_all_sequences( slist, nel, size );
//	Attempt to find all sequences (each of length size and
//	comprising X, X+1, X+2..X+size-1) from sorted slist[nel],
//	modifying slist[] so that the sequences are stored at the
//	front of slist[],
//	ie the first size-elements in slist[] will be the first
//	sequence, etc.
//	Return true if this can be successfully done, or false if it can't.
//
bool find_all_sequences( int *slist, int nel, int size )
{
	if(  nel % size != 0 ) return false;

	int nseqs = nel / size;

	for( int seqno=1; seqno <= nseqs; seqno++ )
	{
		if( debug )
		{
			printf( "debug: seq pass %d, slist is ", seqno );
			print_int_array( 60, nel, slist, ',', stdout );
			putchar( '\n' );
		}
		int pos[size];	// positions of sequence elements
		bool found = find_isolated_seq_posns( size, slist, nel, pos );
		if( ! found )
		{
			if( debug )
			{
				printf( "debug: failed to find a sequence\n" );
			}
			return false;
		}
		if( debug )
		{
			printf( "debug: found seq " );
			for( int i=0; i<size; i++ )
			{
				if( i>0 ) putchar( ',' );
				printf( "%d", slist[pos[i]] );
			}
			printf( " at posns " );
			for( int i=0; i<size; i++ )
			{
				if( i>0 ) putchar( ',' );
				printf( "%d", pos[i] );
			}
			putchar( '\n' );
		}
		reorder( nel, slist, size, pos );
		if( debug )
		{
			printf( "debug: have reordered slist " );
			print_int_array( 60, nel, slist, ',', stdout );
			putchar( '\n' );
		}
		// move array ptr over the new sequence
		nel -= size;
		slist += size;
	}
	return true;
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "rearrange-groups", argc, argv,
		2, 1000, "groupsize intlist" );
	int size = atoi(argv[argno++]);

	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( debug )
	{
		printf( "debug: size=%d, list: ", size );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	qsort( list, nel, sizeof(int), &intcompare );

	if( debug )
	{
		printf( "debug: sorted list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

	bool done = find_all_sequences( list, nel, size );

	if( done )
	{
		int *lp = list;
		for( int i=0; i<nel/size; i++ )
		{
			if( i>0 ) fputs( ", ", stdout );
			putchar( '(' );
			for( int j=0; j<size; j++ )
			{
				if( j>0 ) putchar( ',' );
				printf( "%d", *lp++ );
			}
			putchar( ')' );
		}
		putchar( '\n' );
	} else
	{
		printf( "-1\n" );
	}

	free( list );

	return 0;
}
