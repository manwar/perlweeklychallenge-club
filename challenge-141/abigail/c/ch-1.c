# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <math.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

# define COUNT          10
# define NR_OF_DIVISORS  8

int main (void) {
    int count = COUNT;
    for (int n = 1; count > 0; n ++) {
        long s = lrintf (sqrt (n));
        int m, c;
        if (n == s * s) {
            continue;
        }
        for (m = 1, c = 0; m <= s && c <= NR_OF_DIVISORS; m ++) {
            if (n % m == 0) {
                c += 2;
            }
        }
        if (c == NR_OF_DIVISORS) {
            printf ("%d\n", n);
            count --;
        }
    }
}
