#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

function count (target, this_fib, prev_fib) {
    if (!this_fib) {this_fib = 1}
    if (!prev_fib) {prev_fib = 1}
    return target <  this_fib ? 0                                    \
         : target == this_fib ? 1                                    \
         : count(target - this_fib, this_fib + prev_fib, this_fib) + \
           count(target,            this_fib + prev_fib, this_fib)
}

{
    print count($1)
}
