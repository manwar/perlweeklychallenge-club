# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int main (void) {
    int n, f1, f2;

    while (scanf ("%d", &n) == 1) {
        for (f1 = 0, f2 = 1;n --;) {
            f2 += f1;
            f1  = f2 - f1;
        }
        printf ("%d\n", f2);
    }

    return (0);
}
