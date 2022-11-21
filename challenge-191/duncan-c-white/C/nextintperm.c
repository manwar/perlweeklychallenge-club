#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>


#include "nextintperm.h"


//
// book exhausted = next_perm( arr, n );
//	Find and return the next permutation in lexicographic order
//	of @arr[0..n-1].  Return false if @arr is the last permutation.
//	 1. Find the largest index k such that a[k] < a[k + 1].
//	    If no such index exists, we've found the last permutation.
//       2. Find the largest index l greater than k such that a[k] < a[l].
//       3. Swap the value of a[k] with that of a[l].
//       4. Reverse the sequence from a[k + 1] up to and including the final element a[n].
//
bool next_perm( int *arr, int n )
{
	n--;

	int k, l;
	for( k=n-1; k>=0 && arr[k]>=arr[k+1]; k-- )
	{
	}
	if( k<0 ) return true;
	for( l=n; l>k && arr[k]>=arr[l]; l-- )
	{
	}

	#if 0
	printf( "next_perm: k=%d, l=%d, arr[k]=%d, arr[l]=%d\n",
		k, l, arr[k], arr[l] );
	#endif

	// swap arr[k] and arr[l]
	int t = arr[k];
	arr[k] = arr[l];
	arr[l] = t;

	// reverse arr[k+1]..arr[n]
	if( k+1 < n )
	{
		#if 0
		printf( "next_perm: reversing arr[%d..%d]\n", k+1, n );
		#endif
		int x, y;
		for( x=k+1, y=n; x<y ; x++, y-- )
		{
			int t = arr[x];
			arr[x] = arr[y];
			arr[y] = t;
		}
	}

	return false;
}


