#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

cache = {}

def _count (target, this_fib, prev_fib):
    key = str (target) + ";" + str (this_fib)
    if not (key in cache):
        if target <  this_fib:
            cache [key] = 0
        elif target == this_fib:
            cache [key] = 1
        else:
            cache [key] = \
                _count (target - this_fib, this_fib + prev_fib, this_fib) + \
                _count (target,            this_fib + prev_fib, this_fib)

    return cache [key]

def count (target):
    return (_count (target, 1, 1))

import fileinput

for line in fileinput . input ():
    print (count (int (line)))
