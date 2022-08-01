#!/usr/bin/python3

'''

Week 176:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-176

Task #1: Permuted Multiples

    Write a script to find the smallest integer x such that x, 2x,
    3x, 4x, 5x and 6x are permuted multiples of each other.

'''

import math
import unittest

def hasSameDigits(m, n) -> bool:
    x = [int(a) for a in str(m)]
    y = [int(a) for a in str(n)]
    x.sort()
    y.sort()

    return x == y

def smallestPermutedMultiples() -> int:
    i = 10
    while True:
        found = True
        for j in range(2, 7):
            if not hasSameDigits(i, i * j):
                found = False
                break

        if found:
            return i

        i = i + 1

#
#
# Unit test class

class TestPermutedMultiples(unittest.TestCase):
    def test_PermutedMultiples(self):
        self.assertEqual(142857, smallestPermutedMultiples())

unittest.main()
