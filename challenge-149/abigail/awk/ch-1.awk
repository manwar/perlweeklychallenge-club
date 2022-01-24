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

{
    max_fib = 9 * (1 + length ($1))
    f = 0
    g = 1
    fib [f] = 1
    fib [g] = 1
    while (g < max_fib) {
        t = f + g
        fib [t] = 1
        f = g
        g = t
    }

    for (c = k = 0; c < $1; k ++) {
        if (digit_sum(k) in fib) {
            printf ("%d ", k)
            c ++
        }
    }

    printf ("\n")
}
