# include <stdlib.h>
# include <stdio.h>
# include <math.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int main (void) {
    long double N;
    long double k;

    while (scanf ("%Lf %Lf\n", &N, &k) == 2) {
        printf ("%.10Lf\n", powl (k, 1 / N));
    }

    return (0);
}
