#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

{
    delete numbers
    for (i = 1; i <= NF; i ++) {
        numbers [$i] ++
    }
    for (n in numbers) {
        if (numbers [n] % 2) {
            print n
        }
    }
}
