#!/usr/local/bin/python3

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-150
#

#
# Run as: python ch-2.py
#

import sys

primes = [2, 3, 5, 7, 11, 13, 17, 19]

for n in range (1, 501):
    has_square = False
    for p in primes:
        if n % (p * p) == 0:
            has_square = True
    if not has_square:
        sys . stdout . write (str (n) + " ")
sys . stdout . write ("\n")
