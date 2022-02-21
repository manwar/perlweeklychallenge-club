#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
#

#
# Run as: awk -f ch-1.awk
#

BEGIN {
    sum = 1
    fac = 1
    printf "%d", sum
    for (n = 1; n <= 9; n ++) {
        printf " %d", sum += fac *= n
    }
    printf "\n"
}
