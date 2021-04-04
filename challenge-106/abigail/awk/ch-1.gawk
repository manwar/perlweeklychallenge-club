#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: gawk -f ch-1.gawk < input-file
#

{
    #
    # We don't have lexical variables, so we need to clear
    # the array N in each iteration.
    #
    delete N

    #
    # Read in the data, and populate N
    #
    for (i = 1; i <= NF; i ++) {
        N [i] = $i
    }

    #
    # Sort the array; for numeric values, this sorts numerically.
    #
    asort(N)

    #
    # Find the maximum of the differences. For a single element
    # array, the maximum will be 0.
    #
    max = 0
    for (i = 2; i <= NF; i ++) {
        if (N [i] - N [i - 1] > max) {
            max = N [i] - N [i - 1]
        }
    }

    #
    # Print the result.
    #
    print max
}
