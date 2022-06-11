#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    #
    # Read in tree
    #
    delete tree
    D = 0
    i = 0
    for (k = 0; k < NF; k ++) {
        if ($k == "|") {
            D ++
            i = 0
        }
        else {
            tree [D, i ++] = $k == "*" ? 0 : 1
        }
    }

    #
    # Find first node without children
    #
    for (d = 0; d <= D; d ++) {
        for (i = 0; i < 2 ^ d; i ++) {
            if (tree [d, i] && !tree [d + 1, 2 * i] && 
                               !tree [d + 1, 2 * i + 1]) {
                print d + 1
                next
            }
        }
    }
}


