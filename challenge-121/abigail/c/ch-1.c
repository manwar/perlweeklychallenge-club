# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

int main (void) {
    int m, n;

    while (scanf ("%d %d", &m, &n) == 2) {
        printf ("%d\n", m ^ (1 << -- n));
    }

    return (0);
}
