# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <math.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int main (void) {
    int n;

    while (scanf ("%d", &n) == 1) {
        printf ("%.0f\n", floor (exp (log ((double) n) / 2)));
    }

    return (0);
}
