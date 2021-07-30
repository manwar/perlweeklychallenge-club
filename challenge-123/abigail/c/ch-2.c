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
    int x1, y1, x2, y2, x3, y3, x4, y4;

    while (scanf ("%d %d %d %d %d %d %d %d",
                   &x1, &y1, &x2, &y2, &x3, &y3, &x4, &y4) == 8) {
        int e1 = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
        int e2 = (x2 - x3) * (x2 - x4) + (y2 - y3) * (y2 - y3);
        int e3 = (x3 - x4) * (x3 - x4) + (y3 - y4) * (y3 - y4);
        int e4 = (x4 - x1) * (x4 - x1) + (y4 - y1) * (y4 - y1);
        int d1 = (x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3);
        int d2 = (x2 - x4) * (x2 - x4) + (y2 - y4) * (y2 - y4);

        printf ("%d\n", e1 == e2 && e2 == e3 && e3 == e4 && d1 == d2 ? 1 : 0);
    }

    return (0);
}
