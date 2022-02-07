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
    for (i = NF; i > 0; i --) {
        best [i] = NF <= 2     ? $i                                     \
                 : i == NF     ? $i                                     \
                 : i == 1      ? $i     + best [i + 2]                  \
                 : i == NF - 1 ? max($i,  best [i + 1])                 \
                 :               max($i + best [i + 2], best [i + 1])
    }
    print best [1]
}

