//
// Task 1: Damm Algorithm
// 
// C version.
// 

#include <stdio.h>
#include <stdbool.h>
#include <string.h>

#include "args.h"

int mat[][10] = {
 { 0, 3, 1, 7, 5, 9, 8, 6, 4, 2 },
 { 7, 0, 9, 2, 1, 5, 4, 8, 6, 3 },
 { 4, 2, 0, 6, 8, 7, 1, 3, 5, 9 },
 { 1, 7, 5, 0, 9, 8, 3, 4, 2, 6 },
 { 6, 1, 2, 3, 0, 4, 5, 9, 7, 8 },
 { 3, 6, 7, 4, 2, 0, 9, 5, 8, 1 },
 { 5, 8, 6, 9, 7, 2, 0, 1, 3, 4 },
 { 8, 9, 4, 5, 3, 6, 2, 0, 1, 7 },
 { 9, 4, 3, 8, 6, 1, 7, 2, 0, 5 },
 { 2, 5, 8, 1, 4, 3, 6, 7, 9, 0 },
};

int main( int argc, char **argv )
{
	int n;
	process_onenumarg( "validate-damm", argc, argv, &n );

	int id = 0;	// "interim digit" from Wikipedia page
	char nstr[20];
	sprintf( nstr, "%d", n );
	int len = strlen(nstr);
	for( int pos=0; pos<len; pos++ )
	{
		int digit = nstr[pos]-'0';
		id = mat[id][digit];
	}
	int valid = (id==0)? 1 : 0;
	printf( "%d\n", valid );
	return 0;
}
