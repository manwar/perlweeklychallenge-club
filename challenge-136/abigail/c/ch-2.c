# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * See ../README.md
 */

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o < input-file
 */

int _count (long long target, long long this_fib, long long prev_fib) {
    return target <  this_fib ? 0
         : target == this_fib ? 1
         : _count (target - this_fib, this_fib + prev_fib, this_fib) +
           _count (target,            this_fib + prev_fib, this_fib);
}

int count (long long target) {
    return _count (target, 1, 1);
}

int main (void) {
    long long n;
    while (scanf ("%lld", &n) == 1) {
        printf ("%d\n", count (n));
    }

    return (0);
}
