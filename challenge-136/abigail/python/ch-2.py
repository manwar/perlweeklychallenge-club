#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

def count (target, this_fib, prev_fib):
    if target <  this_fib:
        return (0)
    if target == this_fib:
        return (1)
    return (count (target - this_fib, this_fib + prev_fib, this_fib) +
            count (target,            this_fib + prev_fib, this_fib))

import fileinput

for line in fileinput . input ():
    print (count (int (line), 1, 1))
