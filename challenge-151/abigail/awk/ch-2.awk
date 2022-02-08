#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#

#
# Run as: awk -f ch-2.awk < input-file
#

function max (a, b) {
    return a < b ? b : a
}

{
    delete best
    best [NF + 1] = 0
    best [NF + 2] = 0
    for (i = NF; i > 2; i --) {
        best [i] = max($i + best [i + 2], best [i + 1])
    }
    print $1 + best [3]
}

