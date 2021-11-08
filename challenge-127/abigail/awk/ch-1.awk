#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    delete seen
    for (i = 1; i <= NF; i ++) {
        seen [0 + $i] ++
    }
    for (i in seen) {
        if (seen [i] > 1) {
            print 0
            next
        }
    }
    print 1
}
