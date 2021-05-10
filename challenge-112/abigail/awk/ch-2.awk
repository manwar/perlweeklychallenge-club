#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

BEGIN {
    cache [0] = 1
    cache [1] = 1
}

function fib (n) {
    if (!(n in cache)) {
        cache [n] = fib(n - 1) + fib(n - 2)
    }
    return cache [n]
}

{
    print fib($1)
}
