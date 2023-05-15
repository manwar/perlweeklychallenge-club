// Task 2: Collect Points
//
// C translation

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>

#include "args.h"
#include "parseints.h"
#include "printarray.h"


typedef struct { int startpos, len; } pair;


//
// pair moves[nel];
// int nmoves = all_possible_first_moves( list, nel, moves );
//	Find all possible first (immediate) moves - each move being
//	a (startpos,len) pairs - and store them into moves[nel]
//	and then return the number of moves found.
//
int all_possible_first_moves( int *list, int nel, pair *moves )
{
	int nmoves = 0;
	int pos = 0;
	pair *mp = moves;
	do
	{
		int currval = list[pos];
		int len = 0;
		int startpos;
		for( startpos=pos; pos < nel && list[pos]==currval; pos++ )
		{
			len++;
		}
		mp->startpos = startpos;
		mp->len      = len;
		nmoves++;
		mp++;
	} while( pos < nel );
	return nmoves;
}


int bestsc;
char bestmoves[1024];


//
// find_all( currsc, currmoves, list, nel );
//	Find all possible sequences of moves removing item-sequences
//	from list[nel], given that the current score to this point is currsc,
//	and the current move string to this point is currmoves, and
//	track the best (highest scoring) move sequence in bestsc & bestmoves
//
void find_all( int currsc, char *currmoves, int *list, int nel )
{
	if( nel == 0 )
	{
		if( debug )
		{
			printf( "debug: found solution, currsc=%d, bestsc=%d\n",
				currsc, bestsc );
		}
		if( currsc > bestsc )
		{
			bestsc = currsc;
			strcpy( bestmoves, currmoves );
			if( debug )
			{
				printf( "debug: found new best, bestsc=%d, "
					"bestmoves=%s\n", bestsc, bestmoves );
			}
		}
		return;
	}

	pair moves[nel];
	int nmoves = all_possible_first_moves( list, nel, moves );

	for( int m=0; m<nmoves; m++ )
	{
		int startpos = moves[m].startpos;
		int len = moves[m].len;

		int val = list[startpos];
		int newlist[nel];
		int newnel = 0;

		// newlist = list minus startpos.. startpos+len-1
		for( int i=0; i<startpos; i++ ) newlist[i] = list[i];
		for( int i=startpos+len; i<nel; i++ ) newlist[i-len] = list[i];

		newnel = nel-len;
		newlist[newnel] = -1;

		char newmoves[1024];
		strcpy( newmoves, currmoves );
		if( *newmoves ) strcat( newmoves, "," );
		char *s = newmoves+strlen(newmoves);
		sprintf( s, "%d:%d/%d", val, startpos, len );
		if( debug )
		{
			printf( "debug: list=" );
			print_int_array( 60, nel, list, ',', stdout );
			printf( ", currmoves=%s, removed %d:%d/%d, ",
				currmoves, val, startpos, len );
			printf( "newmoves=%s, made newlist[%d]: ",
				newmoves, newnel );
			print_int_array( 60, newnel, newlist, ',', stdout );
			putchar( '\n' );

		}
		find_all( currsc+len*len, newmoves, newlist, newnel );
	}
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_m_args( "collect-points", argc, argv,
		1, 1000, "intlist" );
	int nel;
	int *list = parse_int_args( argc, argv, argno, &nel );

	if( debug )
	{
		printf( "debug: list: " );
		print_int_array( 60, nel, list, ',', stdout );
		putchar( '\n' );
	}

#if 0
	pair moves[nel];
	int nmoves = all_possible_first_moves( list, nel, moves );

	printf( "found %d moves: ", nmoves );
	for( int i=0; i<nmoves; i++ )
	{
		printf( "%d/%d ", moves[i].startpos, moves[i].len );
	}
	putchar( '\n' );
#endif

	bestsc = 0;
	strcpy( bestmoves, "" );

	find_all( 0, "", list, nel );

	printf( "%d\n%s\n", bestsc, bestmoves );

	free( list );
	return 0;
}
