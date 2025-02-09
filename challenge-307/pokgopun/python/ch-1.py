### https://theweeklychallenge.org/blog/perl-weekly-challenge-307/
"""

Task 1: Check Order

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to re-arrange the given array in an increasing order and
   return the indices where it differs from the original array.

Example 1

Input: @ints = (5, 2, 4, 3, 1)
Output: (0, 2, 3, 4)

Before: (5, 2, 4, 3, 1)
After : (1, 2, 3, 4, 5)

Difference at indices: (0, 2, 3, 4)

Example 2

Input: @ints = (1, 2, 1, 1, 3)
Output: (1, 3)

Before: (1, 2, 1, 1, 3)
After : (1, 1, 1, 2, 3)

Difference at indices: (1, 3)

Example 3

Input: @ints = (3, 1, 3, 2, 3)
Output: (0, 1, 3)

Before: (3, 1, 3, 2, 3)
After : (1, 2, 3, 3, 3)

Difference at indices: (0, 1, 3)

Task 2: Find Anagrams
"""
### solution by pokgopun@gmail.com

from typing import Tuple

def checkOrder(ints: Tuple[int]) -> Tuple[int]:
    sints = sorted(ints)
    return tuple( i for i in range(len(ints)) if ints[i] != sints[i] )

import unittest

class TestCheckOrder(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (5, 2, 4, 3, 1): (0, 2, 3, 4),
                (1, 2, 1, 1, 3): (1, 3),
                (3, 1, 3, 2, 3): (0, 1, 3),
                }.items():
            self.assertEqual(checkOrder(inpt), otpt)

unittest.main()
