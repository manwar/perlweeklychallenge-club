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
    for (i = NF; i > 2; i --) {
        $i = max($i + $(i + 2), $(i + 1))
    }
    print $1 + $3
}

