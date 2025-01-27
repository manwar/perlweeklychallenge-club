### https://theweeklychallenge.org/blog/perl-weekly-challenge-306/
"""

Task 1: Odd Sum

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of positive integers, @ints.

   Write a script to return the sum of all possible odd-length subarrays
   of the given array. A subarray is a contiguous subsequence of the
   array.

Example 1

Input: @ints = (2, 5, 3, 6, 4)
Output: 77

Odd length sub-arrays:
(2) => 2
(5) => 5
(3) => 3
(6) => 6
(4) => 4
(2, 5, 3) => 10
(5, 3, 6) => 14
(3, 6, 4) => 13
(2, 5, 3, 6, 4) => 20

Sum => 2 + 5 + 3 + 6 + 4 + 10 + 14 + 13 + 20 => 77

Example 2

Input: @ints = (1, 3)
Output: 4

Task 2: Last Element
"""
### solution by pokgopun@gmail.com

from typing import Tuple

def odsm(ints: Tuple[int])-> int:
        sm = 0
        l = len(ints)
        for o in range(1, l+1, 2):
            i = 0
            while i + o <= l:
                sm += sum(ints[i:i+o])
                i += 1
        return sm

import unittest

class TestOdsm(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (2, 5, 3, 6, 4): 77,
                (1, 3): 4,
                }.items():
            self.assertEqual(odsm(inpt),otpt)

unittest.main()


