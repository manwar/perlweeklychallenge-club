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
    while (g < n) {
        t = g
        g = f + g
        f = t
        fib [g] = 1
    }
    return n in fib
}

BEGIN {
    f       = 0
    g       = 1
    fib [f] = 1
    fib [g] = 1
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
