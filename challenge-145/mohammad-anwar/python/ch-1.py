#!/usr/bin/python3

'''

Week 145:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-145

Task #1: Dot Product

    You are given 2 arrays of same size, @a and @b.

    Write a script to implement Dot Product.

'''

import unittest

def dot_product(a, b):

    if len(a) == len(b):
        dp = 0
        for i in range(0, len(a)):
            dp += a[i] * b[i]

    return dp;

#
#
# Unit test class

class TestJortSort(unittest.TestCase):

    def test_example(self):
        self.assertEqual(
            dot_product([1,2,3], [4,5,6]),
            32,
            'Example')

unittest.main()
