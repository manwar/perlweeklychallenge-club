#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    sorted = 1
    for (i = 2; i <= NF; i ++) {
        if ($(i - 1) > $i) {
            sorted = 0
        }
    }
    print sorted
}
