#!/usr/bin/python3

'''

Week 170:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-170

Task #1: Primorial Numbers

    Write a script to generate first 10 Primorial Numbers.

'''

import math
import unittest

def is_prime(n):
    if n == 1:
        return 0

    i = 2
    while (i <= int(math.sqrt(n))):
        if ((n % i) == 0):
            return 0
        i += 1

    return 1

def primorial_numbers(n):
    pn = []
    i  = 0
    j  = 1
    while (len(pn) < n):
        i = i + 1
        if (is_prime(i) != 1):
            continue
        j = i * j
        pn.append(j)

    return pn

#
#
# Unit test class

class TestPrimorialNumbers(unittest.TestCase):

    def test_example(self):
        self.assertEqual(
            primorial_numbers(10),
            [2, 6, 30, 210, 2310, 30030, 510510, 9699690, 223092870, 6469693230],
            'Example'
        )

unittest.main()
