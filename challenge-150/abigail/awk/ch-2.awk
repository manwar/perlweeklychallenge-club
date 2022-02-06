#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
#

#
# Run as: awk -f ch-2.awk
#

BEGIN {
    split ("2 3 5 7 11 13 17 19", primes)
    for (n = 1; n <= 500; n ++) {
        s = 1
        for (p = 1; p <= 8 && s; p ++) {
            s *= n % (primes [p] * primes [p])
        }
        if (s) {
            printf "%d ", n
        }
    }
    printf "\n"
}
