#!/usr/local/bin/python3

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-153
#

#
# Run as: python ch-1.py
#

import sys;

fac = 1
sum = 1

sys . stdout . write (str (sum))

for n in range (1, 10):
    fac = fac * n
    sum = sum + fac
    sys . stdout . write (" " + str (sum))

sys . stdout . write ("\n")
