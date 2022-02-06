#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    fib_prev = $1
    fib_last = $2
    LENGTH = 51
    while (length (fib_last) < LENGTH) {
        fib_tmp  = fib_last
        fib_last = fib_prev fib_last
        fib_prev = fib_tmp
    }
    print substr (fib_last, LENGTH, 1)
}
