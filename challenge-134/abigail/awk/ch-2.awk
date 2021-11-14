#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

{
    delete a
    for (i = 1; i <= $1; i ++) {
        for (j = 1; j <= $2; j ++) {
            a [i * j] = 1
        }
    }
    c = 0
    for (i in a) {
        c ++
    }
    print c
}
