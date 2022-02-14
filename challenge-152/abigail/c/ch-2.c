# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int min (int a, int b) {return a < b ? a : b;}
int max (int a, int b) {return a < b ? b : a;}

int main (void) {
    int a_x1, a_y1, a_x2, a_y2, b_x1, b_y1, b_x2, b_y2;

    while (scanf ("%d%d%d%d%d%d%d%d", &a_x1, &a_y1, &a_x2, &a_y2,
                                      &b_x1, &b_y1, &b_x2, &b_y2) == 8) {
        printf ("%d\n",              (max (a_x1, a_x2) - min (a_x1, a_x2))  *
                                     (max (a_y1, a_y2) - min (a_y1, a_y2))  +
                                     (max (b_x1, b_x2) - min (b_x1, b_x2))  *
                                     (max (b_y1, b_y2) - min (b_y1, b_y2))  -
                         max (0, min (max (a_x1, a_x2),  max (b_x1, b_x2))  - 
                                 max (min (a_x1, a_x2),  min (b_x1, b_x2))) *
                         max (0, min (max (a_y1, a_y2),  max (b_y1, b_y2))  -
                                 max (min (a_y1, a_y2),  min (b_y1, b_y2))));
    }
    return (0);
}
