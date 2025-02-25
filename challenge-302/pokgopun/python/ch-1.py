### https://theweeklychallenge.org/blog/perl-weekly-challenge-302/
"""

Task 1: Ones and Zeroes

Submitted by: [68]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of binary strings, @str, and two integers, $x
   and $y.

   Write a script to return the size of the largest subset of @str such
   that there are at most $x 0’s and $y 1’s in the subset.
A set m is a subset of n if all elements of m are also elements of n.

Example 1

Input: @str = ("10", "0001", "111001", "1", "0")
       $x = 5
       $y = 3
Output: 4

The largest subset with at most five 0's and three 1's:
("10", "0001", "1", "0")

Example 2

Input: @str = ("10", "1", "0")
       $x = 1
       $y = 1
Output: 2

The largest subset with at most one 0's and one 1's:
("1", "0")

Task 2: Step by Step
"""
### solution by pokgopun@gmail.com

from itertools import combinations
from typing import Tuple

def oaz(bins: Tuple[int], x: int, y: int) -> int:
    szo = tuple((e.count("0"),e.count("1")) for e in bins)
    for n in range(len(szo),0,-1):
        for cmb in combinations(szo, n):
            if sum(e[0] for e in cmb) <= x and sum(e[1] for e in cmb) <= y:
                return n
    return len(szo)

import unittest

class TestOaz(unittest.TestCase):
    def test(self):
        for (bins, x, y), otpt in {
                (("10", "0001", "111001", "1", "0"), 5, 3): 4,
                (("10", "1", "0"), 1, 1): 2,
                }.items():
            self.assertEqual(oaz(bins, x, y), otpt)

unittest.main()
