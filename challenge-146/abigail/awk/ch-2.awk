#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

BEGIN {
    FS = "/"
}

{
    a = $1; b = $2
    for (i = 1; i <= 2; i ++) {
        if (a < b) {
            b = b - a
        }
        else {
            a = a - b
        }
        if (!a || !b) {
            break
        }
        printf "%d/%d ", a, b
    }
    printf "\n"
}
