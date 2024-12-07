### https://theweeklychallenge.org/blog/perl-weekly-challenge-297/
"""

Task 1: Contiguous Array

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of binary numbers, @binary.

   Write a script to return the maximum length of a contiguous subarray
   with an equal number of 0 and 1.

Example 1

Input: @binary = (1, 0)
Output: 2

(1, 0) is the longest contiguous subarray with an equal number of 0 and 1.

Example 2

Input: @binary = (0, 1, 0)
Output: 2

(1, 0) or (0, 1) is the longest contiguous subarray with an equal number of 0 an
d 1.

Example 3

Input: @binary = (0, 0, 0, 0, 0)
Output: 0

Example 4

Input: @binary = (0, 1, 0, 0, 1, 0)
Output: 4

Task 2: Semi-Ordered Permutation
"""
### solution by pokgopun@gmail.com

from typing import Tuple

def ca(bins: Tuple[int]) -> int:
    l = len(bins)
    i = 0
    c = 0
    while l - i > 1:
        if bins[i] != bins[i+1]:
            c += 2
            i += 2
        else:
            i += 1
    return c

import unittest

class TestCA(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (1, 0): 2,
                (0, 1, 0): 2,
                (0, 0, 0, 0, 0): 0,
                (0, 1, 0, 0, 1, 0): 4,
                (0, 1, 1, 0, 1, 0): 6,
                (0, 1, 1, 0, 1, 0, 1, 1): 6,
                }.items():
            #print(inpt,otpt)
            self.assertEqual(ca(inpt), otpt)

unittest.main()
