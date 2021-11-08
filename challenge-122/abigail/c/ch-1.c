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
    int n;
    int s = 0;
    int c = 0;

    while (scanf ("%d", &n) == 1) {
        printf ("%d\n", (s += n) / ++ c);
    }

    return (0);
}
