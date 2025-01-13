### https://theweeklychallenge.org/blog/perl-weekly-challenge-304/
"""

Task 1: Arrange Binary

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of binary digits (0 and 1) and a positive integer,
   $n.

   Write a script to return true if you can re-arrange the list by
   replacing at least $n digits with 1 in the given list so that no two
   consecutive digits are 1 otherwise return false.

Example 1

Input: @digits = (1, 0, 0, 0, 1), $n = 1
Output: true

Re-arranged list: (1, 0, 1, 0, 1)

Example 2

Input: @digits = (1, 0, 0, 0, 1), $n = 2
Output: false

Task 2: Maximum Average
"""
### solution by pokgopun@gmail.com
from typing import Tuple

def ab(ints: Tuple[int], n: int) -> bool:
    l = len(ints) - 1
    i = 0
    while i < l:
        if ints[i] == 1:
            if ints[i+1] == 1:
                return False
            i += 2
            continue
        if ints[i+1] == 0:
            n -= 1
            i += 2
            continue
        i += 1
    return n <= 0

import unittest

class testAb(unittest.TestCase):
    def test(self):
        for (ints, n), otpt in {
                ((1, 0, 0, 0, 1), 1): True,
                ((1, 0, 0, 0, 1), 2): False,
                ((1, 1, 0, 0, 0, 1), 1): False,
                ((1, 0, 0, 0, 1, 1), 1): False,
                }.items():
            self.assertEqual(ab(ints, n), otpt)

unittest.main()
