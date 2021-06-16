#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

function steps (x, y, path) {
    if (x == 0 && y == 0) {
        print path
        return
    }
    if (x > 0) {
        steps(x - 1, y,     path "R")
        steps(x - 1, y + 1, path "L")
    }
    if (y > 0) {
        steps(x,     y - 1, path "H")
    }
}

{
    steps($1, 0, "")
}
