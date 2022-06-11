#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    minsum = $1

    min = 0
    n   = 2
    m   = n
    for (i = 2; i <= NF; i ++) {
        if (m == n || $i < min) {
            min = $i
        }
        if (-- m == 0) {
            minsum += min
            m       = ++ n
            min     = 0
        }
    }

    print minsum
}

