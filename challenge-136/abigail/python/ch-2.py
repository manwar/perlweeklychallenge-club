#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

def _count (target, this_fib, prev_fib):
    if target <  this_fib:
        return (0)
    if target == this_fib:
        return (1)
    return (_count (target - this_fib, this_fib + prev_fib, this_fib) +
            _count (target,            this_fib + prev_fib, this_fib))

def count (target):
    return (_count (target, 1, 1))

import fileinput

for line in fileinput . input ():
    print (count (int (line)))
