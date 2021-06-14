#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

function steps (x, y, prefix) {
    if (x == 0 && y == 0) {
        print prefix
        return
    }
    if (x > 0) {
        steps(x - 1, y,     prefix "R")
        steps(x - 1, y + 1, prefix "L")
    }
    if (y > 0) {
        steps(x,     y - 1, prefix "H")
    }
}

{
    steps($1, 0, "")
}
