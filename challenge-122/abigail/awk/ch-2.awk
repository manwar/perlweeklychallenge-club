#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

{
    c [0] = 0
    c [1] = 0
    c [2] = 1
    s [2, 0] = ""

    for (i = 3; i < $1 + 3; i ++) {
        c [i] = 0
        for (j = 1; j <= 3; j ++) {
            for (k = 0; k < c [i - j]; k ++) {
                s [i, c [i]] = j " " s [i - j, k]
                c [i] ++
            }
        }
    }

    for (k = 0; k < c [$1 + 2]; k ++) {
        print s [$1 + 2, k]
    }
}
