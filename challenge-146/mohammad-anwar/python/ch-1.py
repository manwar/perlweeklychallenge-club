#!/usr/bin/python3

'''

Week 146:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-146

Task #1: 10001st Prime Number

    Write a script to generate the 10001st prime number.

'''

import math
import unittest

def is_prime(n):
    i = 2
    while (i <= int(math.sqrt(n))):
        if ((n % i) == 0):
            return 0
        i += 1

    return 1

def find_prime(count):
    c = 0
    n = 2
    while (c <= count):
        if (is_prime(n) == 1):
            c += 1
            if (c == count):
                return n
        n += 1

#
#
# Unit test class

class TestFindPrimeNumber(unittest.TestCase):

    def test_example(self):
        self.assertEqual(
            find_prime(10001),
            104743,
            'Example'
        )

unittest.main()
