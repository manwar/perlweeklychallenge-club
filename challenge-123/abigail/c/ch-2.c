# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int dist (int x1, int y1, int x2, int y2) {
    return ((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
}

int main (void) {
    int x1, y1, x2, y2, x3, y3, x4, y4;

    while (scanf ("%d %d %d %d %d %d %d %d",
                   &x1, &y1, &x2, &y2, &x3, &y3, &x4, &y4) == 8) {
        printf ("%d\n", dist (x1, y1, x2, y2) == dist (x2, y2, x3, y3) &&
                        dist (x2, y2, x3, y3) == dist (x3, y3, x4, y4) &&
                        dist (x3, y3, x4, y4) == dist (x4, y4, x1, y1) &&
                        dist (x1, y1, x3, y3) == dist (x2, y2, x4, y4) ? 1 : 0);
    }

    return (0);
}
