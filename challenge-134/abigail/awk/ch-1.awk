#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk
#

BEGIN {
    split ("789 798 879 897 978", a, " ")
    for (i = 1; i <= 5; i ++) {
        print "1023456" a [i]
    }
}
