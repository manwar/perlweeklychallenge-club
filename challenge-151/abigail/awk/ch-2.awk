#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#

#
# Run as: awk -f ch-2.awk < input-file
#

function best (i, max, sum, k) {
    if (!(i in cache)) {
        max = 0
        for (k = i + 2; k <= NF; k ++) {
            sum = best(k)
            if (sum > max) {
                max = sum
            }
        }
        cache [i] = $i + max
    }
    return cache [i]
}

{
    delete cache
    print best(1)
}
