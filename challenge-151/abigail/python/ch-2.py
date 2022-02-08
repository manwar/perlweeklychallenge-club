#!/usr/local/bin/python3

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

for line in fileinput . input ():
    h = list (map (lambda x: int (x), line . strip () . split ()))
    h . append (0)
    h . append (0)
    for i in range (len (h) - 3, 1, -1):
        h [i] = max (h [i] + h [i + 2], h [i + 1])
    print (h [0] + h [2])
