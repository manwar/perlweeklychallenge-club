#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
#

#
# Run as: awk -f ch-1.awk < input-file
#

BEGIN {
    fac [0] = 1
    for (n = 1; n <= 9; n ++) {
        fac [n] = n * fac [n - 1]
    }
}

{
    sum = 0
    n = $1
    while (n > 0) {
        sum += fac [n % 10]
        n    = int (n / 10)
    }
    print sum == $1 ? 1 : 0
}
