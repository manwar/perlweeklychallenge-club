#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

cache = {0: 1, 1: 1}

def fib (n):
    if not n in cache:
        cache [n] = fib (n - 1) + fib (n - 2)
    return (cache [n])

for line in fileinput . input ():
    print (fib (int (line)))
