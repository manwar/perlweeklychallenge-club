#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
#

#
# Run as: awk -f ch-1.awk < input-file
#

function digit_sum (number, sum) {   
    sum = 0
    while (number > 0) {
        sum   += number % 10
        number = int (number / 10)
    }
    return sum
}

function is_fib (n, t) {
    while (fib_last < n) {
        t        = fib_last
        fib_last = fib_prev + fib_last
        fib_prev = t
        fib [fib_last] = 1
    }
    return n in fib
}

BEGIN {
    fib_prev       = 0
    fib_last       = 1
    fib [fib_prev] = 1
    fib [fib_last] = 1
}

{
    N = $1
    for (k = 0; N > 0; k ++) {
        if (is_fib(digit_sum(k))) {
            printf ("%d ", k)
            N --
        }
    }

    printf ("\n")
}
