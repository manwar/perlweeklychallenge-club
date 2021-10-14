#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk
#

BEGIN {
    n = split ("789 798 879 897 978", tails, " ")
    for (i = 1; i <= n; i ++) {
        print "1023456" tails [i]
    }
}
