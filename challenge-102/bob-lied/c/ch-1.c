/* vim:set ts=4 sw=4 sts=4 et ai wm=0 nu syntax=c: */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int verbose = 1;

int mightBeRare[10]   = { 1, 0, 1, 1, 0, 1, 0, 1, 1, 0 };

int mightBeSquare[10] = { 1, 1, 0, 0, 1, 1, 1, 0, 0, 1 };

long
reverse(long r)
{
    long r1 = 0;
    while ( r )
    {
        r1 = r1 * 10 + r%10;
        r /= 10;
    }
    return r1;
}


int
main(int argc, char **argv)
{
    int N;

    N = atoi(argv[1]);

    int isNodd = N % 2;

    long scale = pow(10, (N-1));
    long endOfRange = pow(10, N);

    for ( long r = scale ; r < endOfRange ; r++ )
    {
        // Rare numbers can never start with an odd digit.
        if ( (r / scale ) % 2 )
        {
            r += scale;
        }

// if ( r % 10000000 == 0 ) printf("%ld\n", r);

        if ( ! mightBeRare[ r % 10 ] )
        {
            continue;
        }

        long r1 = reverse(r);

        long y2 = r - r1;
        if ( y2 < 0 ) continue; // Can't be a square

        long x2 = r + r1;

        if ( !( mightBeSquare[ x2%10]  &&  mightBeSquare[ y2%10 ] ) )  continue;

        if ( isNodd )
        {
            if ( y2 % 1089 ) continue;
        }
        else
        {
            if ( x2 % 121 ) continue;
        }

        double x = sqrt(x2);
        if ( x != (long)(x) ) continue;

        double y = sqrt(y2);
        if ( y != (long)(y) ) continue;

        printf("N=%d R=%ld\n", N, r);
    }


    exit(0);
}
