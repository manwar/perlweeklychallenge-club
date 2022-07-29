#!/usr/bin/python3

'''

Week 175:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-175

Task #2: Perfect Totient Numbers

    Write a script to generate first 20 Perfect Totient Numbers.

'''

import math
import unittest

def isCoprime(a, b) -> bool:
    return math.gcd(a, b) == 1

#
# Simply coded as shown in the example in the wiki page:
# https://en.wikipedia.org/wiki/Perfect_totient_number

def isPerfectTotient(n) -> bool:
    i = n
    s = 0
    while i >= 1:
        coprimes = []
        for j in range(1, i):
            if isCoprime(i, j):
                coprimes.append(j)

        i = len(coprimes)
        s = s + i

    return n == s

def firstPerfectTotient(n):
    pt = []
    i  = 1
    while (len(pt) < n):
        if isPerfectTotient(i):
            pt.append(i)
        i = i + 1

    return pt

#
#
# Unit test class

class TestPerfectTotient(unittest.TestCase):
    def test_firstPerfectTotient(self):
        exp = [
            3, 9, 15, 27, 39, 81, 111, 183, 243,
            255, 327, 363, 471, 729, 2187, 2199,
            3063, 4359, 4375, 5571
        ]
        got = firstPerfectTotient(20)
        self.assertEqual(exp, got)

unittest.main()
