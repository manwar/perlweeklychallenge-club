# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

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

bool is_power_of_n (long long number, long long n) {
    return number <  1 ? false
         : number == 1 ? true
         : number %  n ? false
         : is_power_of_n (number / n, n);
}
bool is_power_of_2 (long long number) {
    return is_power_of_n (number, 2);
}
     


int main (void) {
    long long n, m;

    while (scanf ("%lld %lld", &n, &m) == 2) {
        long long r = gcd (n, m);
        printf ("%d\n", r > 1 && is_power_of_2 (r) ? 1 : 0);
    }

    return (0);
}
