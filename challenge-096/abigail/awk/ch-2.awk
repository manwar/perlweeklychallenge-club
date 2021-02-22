#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

#
# Return the minimum of 3 values
#
function min (a, b, c) {
    return a < b ? a < c ? a : c\
                 : b < c ? b : c
}

#
# This is an implementation of the Wagner Fischer algorithm, which
# calculates the Levenshtein distance.
#
# See https://en.wikipedia.org/wiki/Wagner%E2%80%93Fischer_algorithm
#
{
    for (i = 0; i <= length ($1); i ++) {
        for (j = 0; j <= length ($2); j ++) {
            distance [i, j] = i == 0 || j == 0 ? i + j\
                     : min(distance [i - 1, j]     + 1,
                           distance [i,     j - 1] + 1,
                           distance [i - 1, j - 1] +\
                           (substr ($1, i, 1) == substr ($2, j, 1) ? 0 : 1))
        }
    }
    print distance [length ($1), length ($2)]
}
