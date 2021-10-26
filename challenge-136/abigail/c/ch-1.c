# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */


/*
 * Find the GCD, using Stein's algorithm
 *    (https://en.wikipedia.org/wiki/Binary_GCD_algorithm)
 */
long long gcd (long long u, long long v) {
    long long u_odd = u % 2;
    long long v_odd = v % 2;

    return u == v || !v ? u
         :           !u ? v
         : !u_odd && !v_odd ? gcd (u >> 1, v >> 1) << 1
         : !u_odd &&  v_odd ? gcd (u >> 1, v)
         :  u_odd && !v_odd ? gcd (u,      v >> 1)
         :  u     >   v     ? gcd (u - v,  v)
         :                    gcd (v - u,  u);
}


int main (void) {
    long long n, m;

    while (scanf ("%lld %lld", &n, &m) == 2) {
        long long ggcd = gcd (n, m);
        short valid = 0;
        /*
         * Check whether ggcd is a power of 2
         */
        if (ggcd > 1) {
            while (ggcd % 2 == 0) {
                ggcd /= 2;
            }
            if (ggcd == 1) {
                valid = 1;
            }
        }
        printf ("%d\n", valid);
    }

    return (0);
}
