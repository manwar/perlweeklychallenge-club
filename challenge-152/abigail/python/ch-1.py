#!/usr/local/bin/python3

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-152
#

#
# Run as: python ch-1.py < input-file
#

import fileinput

for line in fileinput . input ():
    minsum = 0
    n      = 1
    m      = n
    min    = 0
    for num in line . strip () . split (" "):
        num = int (num)
        if n == m or num < min:
            min = num
        m = m - 1
        if m == 0:
            n      = n + 1
            m      = n
            minsum = minsum + min
            min    = 0
    print (minsum)
