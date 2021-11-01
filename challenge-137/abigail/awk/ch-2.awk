#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

function reverse (str) {
    x = ""
    for (i = length (str); i != 0; i --) {
        x = x substr (str, i, 1)
    }
    return x
}

function ly (n) {
    return n >= 10000000 ? 1 : n == reverse(n) ? 0 : ly(n + reverse(n))
}

{print ly($1)}
