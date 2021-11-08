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

typedef long long number;

number introot (number square) {
    return ((number) floorl (.4 + sqrt (square)));
}

int main (void) {
    number n;

    while (scanf ("%lld", &n) == 1) {
        if (n <= 2) {
            printf ("-1\n");
            continue;
        }

        number n_sq = n * n;
        number c    = n + 1;
        number c_sq = n_sq + 2 * n + 1;
        while (2 * c - 1 <= n_sq) {
            number b_sq = c_sq - n_sq;
            number b    = introot (b_sq);
            if (b_sq == b * b) {
                printf ("%lld %lld %lld\n", n, b, c);
            }
            c_sq += 2 * c ++ + 1;
        }

        number max_a = (number) floorl (n / sqrt (2));
        for (number a = 3; a <= max_a; a ++) {
            number b_sq = n_sq - a * a;
            number b    = introot (b_sq);
            if (b_sq == b * b) {
                printf ("%lld %lld %lld\n", a, b, n);
            }
        }
    }

    return (0);
}
