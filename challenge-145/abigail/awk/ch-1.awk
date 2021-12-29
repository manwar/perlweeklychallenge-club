#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    for (i = 1; i <= NF; i ++) {
        if (NR == 1) {
            a [i] = $i
        }
        else {
            sum += a [i] * $i
        }
    }
    if (NR == 2) {
        print sum
    }
}
