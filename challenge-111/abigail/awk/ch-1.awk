#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

BEGIN {
    MATRIX_SIZE = 5
}

#
# Read in the matrix first
#
NR <= MATRIX_SIZE {
    for (i = 1; i <= NF; i ++) {
        matrix [$i] = 1
    }
}

#
# For the rest, print 1/0 depending on whether the input
# is in the matrix or not.
#
NR > MATRIX_SIZE {
    print (matrix [$0] ? 1 : 0)
}
