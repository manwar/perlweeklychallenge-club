# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

/*
 * See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o
 */

# define MAX 500
# define   P   8

int main (void) {
    short primes [P] = {2, 3, 5, 7, 11, 13, 17, 19};
    for (short n = 1; n <= MAX; n ++) {
        bool has_square = false;
        for (size_t p = 0; p < P && !has_square; p ++) {
            if (n % (primes [p] * primes [p]) == 0) {
                has_square = true;
            }
        }
        if (!has_square) {
            printf ("%d ", n);
        }
    }
    printf ("\n");
}
