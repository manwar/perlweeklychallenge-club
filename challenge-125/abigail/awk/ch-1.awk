#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

function introot (square) {
    return (int (.4 + sqrt (square)))
}


$1 <= 2 {
    print (-1)
    next
}


{
    n    = $1
    n_sq = n * n
    c    = n + 1
    c_sq = n_sq + 2 * n + 1
    while (2 * c - 1 <= n_sq) {
        b_sq = c_sq - n_sq
        b    = introot(b_sq)
        if (b_sq == b * b) {
            print n, b, c
        }
        c_sq += 2 * c ++ + 1
    }

    max_a = int (n / sqrt (2))
    for (a = 3; a <= max_a; a ++) {
        b_sq = n_sq - a * a
        b    = introot(b_sq)
        if (b_sq == b * b) {
            print a, b, n
        }
    }
}
