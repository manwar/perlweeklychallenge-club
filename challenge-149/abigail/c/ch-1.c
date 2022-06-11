# include <stdlib.h>
# include <stdio.h>
# include <string.h>
# include <stdbool.h>

/*
 * See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
 */

/*
 * Run as: cc -o ch-1.o ch-1.c; ./ch-1.o < input-file
 */

# define BASE 10
int digit_sum (long n) {
    int out = 0;
    while (n) {
        out += n % BASE;
        n   /= BASE;
    }
    return (out);
}

# define DEFAULT_FIB_CAB  100
# define FIB_CAP_INC_PERC  50

typedef long fib_t;

fib_t   fib_prev, fib_last;
size_t  fib_count;
size_t  fib_cap;
fib_t * fib = NULL;

bool is_fib (fib_t n) {
    if (fib == NULL) {
        fib_prev  = 1;
        fib_last  = 1;
        fib_count = 2;
        fib_cap   = DEFAULT_FIB_CAB;
        if ((fib = (fib_t *) malloc (fib_cap * sizeof (fib_t))) == NULL) {
            perror ("Malloc failed");
            exit (1);
        }
        fib [0] = 0;
        fib [1] = 1;
    }

    /*
     * If n exceeds the maximum Fibonacci number so far, generate
     * new numbers until we reach or exceed n. If we generate n,
     * n is a Fibonacci number; if we exceed n, n is not.
     */
    while (fib_last < n) {
        fib_t t   = fib_last;
        fib_last += fib_prev;
        fib_prev  = t;
        while (fib_count >= fib_cap) {
            fib_cap += 1 + FIB_CAP_INC_PERC * fib_cap / 100;
            if ((fib = (fib_t *)
                       realloc (fib, fib_cap * sizeof (fib_t))) == NULL) {
                perror ("Ralloc failed");
                exit (1);
            }
        }
        fib [fib_count ++] = fib_last;
        if (fib_last == n) {
            return (true);
        }
        if (fib_last > n) {
            return (false);
        }
    }

    /*
     * If n is less than the maximum Fibonaccie number generated so far,
     * do a binary search.
     */
    size_t min = 0;
    size_t max = fib_count;
    while (min < max) {
        size_t mid = (min + max) / 2;
        if (fib [mid] == n) {
            return (true);
        }
        if (fib [mid] < n) {
            min = mid + 1;
        }
        else {
            max = mid;
        }
    }
    return (false);
}



int main (void) {
    int n;

    while (scanf ("%d", &n) == 1) {
        for (int k = 0; n > 0; k ++) {
            if (is_fib (digit_sum (k))) {
                printf ("%d ", k);
                n --;
            }
        }
        printf ("\n");
    }

    return (0);
}
