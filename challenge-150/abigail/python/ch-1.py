#!/usr/local/bin/python3

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    fib_prev, fib_last = line . strip () . split (" ")
    while len (fib_last) < 51:
        fib_prev, fib_last = fib_last, fib_prev + fib_last
    print (fib_last [50:51])
