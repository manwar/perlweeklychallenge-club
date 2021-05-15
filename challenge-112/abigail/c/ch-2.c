# include <stdlib.h>
# include <stdio.h>
# include <math.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

# define SQRT5 (sqrt (5))
# define PHI   ((1 + SQRT5) / 2)

int main (void) {
    int n;

    while (scanf ("%d", &n) == 1) {
        printf ("%lld\n", (long long) floor (0.5 + pow (PHI, n + 1) / SQRT5));
    }

    return (0);
}
