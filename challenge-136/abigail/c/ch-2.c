# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int count (long long target, long long this_fib, long long prev_fib) {
    return target <  this_fib ? 0
         : target == this_fib ? 1
         : count (target - this_fib, this_fib + prev_fib, this_fib) +
           count (target,            this_fib + prev_fib, this_fib);
}

int main (void) {
    long long n;
    while (scanf ("%lld", &n) == 1) {
        printf ("%d\n", count (n, 1, 1));
    }

    return (0);
}
