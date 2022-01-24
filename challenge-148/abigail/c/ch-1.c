# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o
 */

int main (void) {
    for (int i = 0; i <= 100; i ++) {
        int u = i % 10;
        int t = i / 10;
        if (!(i == 0 || t == 1 || u == 1 || t == 7 || u == 7
                     || t == 8 || u == 8 || t == 9 || u == 9
                     || t == 2 || u == 3 || u == 5 || i == 100)) {
            printf ("%d ", i);
        }
    }
    printf ("\n");
}
