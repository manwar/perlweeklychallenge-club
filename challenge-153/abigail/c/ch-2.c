# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int main (void) {
    int fac [10];
    int num;

    fac [0] = 1;
    for (int n = 1; n <= 9; n ++) {
        fac [n] = n * fac [n - 1];
    }

    while (scanf ("%d", &num) == 1) {
        int n = num;
        int sum = 0;
        while (n > 0) {
            sum += fac [n % 10];
            n   /= 10;
        }
        printf ("%d\n", num == sum ? 1 : 0);
    }

    return (0);
}
