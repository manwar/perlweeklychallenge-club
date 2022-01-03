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
    int a, b;

    while (scanf ("%d/%d", &a, &b) == 2) {
        for (int i = 1; i <= 2; i ++) {
            if (a < b) {
                b -= a;
            }
            else {
                a -= b;
            }
            if (!a || !b) {
                break;
            }
            printf ("%d/%d ", a, b);
        }
        printf ("\n");
    }

    return (0);
}
