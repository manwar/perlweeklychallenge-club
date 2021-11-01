#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#


function count (target, this_fib, prev_fib, key) {
    if (!this_fib) {this_fib = 1}
    if (!prev_fib) {prev_fib = 1}
    key = target ";" this_fib
    if (!(key in cache)) {
        cache [key] = target <  this_fib ? 0                                   \
                    : target == this_fib ? 1                                   \
                    : count(target - this_fib, this_fib + prev_fib, this_fib) +\
                      count(target,            this_fib + prev_fib, this_fib)
    }
    return cache [key]
}

{
    print count($1)
}
