#!/usr/local/bin/python3

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-151
#

#
# Run as: python ch-2.py < input-file
#

import fileinput

for line in fileinput . input ():
    houses = list (map (lambda x: int (x), line . strip () . split ()))
    best   = [0] * (len (houses) + 2)
    for i in range (len (houses) - 1, 1, -1):
        best [i] = max (houses [i] + best [i + 2], best [i + 1])
    print (houses [0] + best [2])
