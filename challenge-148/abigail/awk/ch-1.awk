#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
#

#
# Run as: awk -f ch-1.awk
#

BEGIN {
    for (i = 0; i <= 100; i ++) {
        if (! match (i, /^0$|[1789]|^2.|[35]$/)) {
            printf ("%d ", i)
        }
    }
    printf ("\n")
}

