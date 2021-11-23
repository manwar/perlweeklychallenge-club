# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <math.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int main (void) {
    long i, j;
    long long k;

    while (scanf ("%ld%ld%lld", &i, &j, &k) == 3) {
        long long n = 0;
        while (k > 0) {
            long s = lrintf (sqrt (++ n));
            for (long d = 1; d <= s && k > 0; d ++) {
                /*
                 * Subtract the number of divisors d, where d <= i,
                 * and n / d <= j, or d <= j and n / d <= i.
                 * A number d is a divisor if n % d == 0.
                 * We should count a divisor only once if n == d * d.
                 */
                if (!(n % d)) {
                    k -= (d <= i && n / d <= j) +
                         (d <= j && n / d <= i) - (n == d * d);
                }
            }
        }
        printf ("%lld\n", n);
    }

    return (0);
}
