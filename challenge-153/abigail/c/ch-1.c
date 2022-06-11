# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o
 */

int main (void) {
    int sum = 1;
    int fac = 1;
    printf ("%d", sum);
    for (int n = 1; n <= 9; n ++) {
        printf (" %d", sum += fac *= n);
    }
    printf ("\n");
    return (0);
}
