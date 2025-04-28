### https://theweeklychallenge.org/blog/perl-weekly-challenge-319/
"""

Task 2: Minimum Common

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two arrays of integers.

   Write a script to return the minimum integer common to both arrays. If
   none found return -1.

Example 1

Input: @array_1 = (1, 2, 3, 4)
       @array_2 = (3, 4, 5, 6)
Output: 3

The common integer in both arrays: 3, 4
The minimum is 3.

Example 2

Input: @array_1 = (1, 2, 3)
       @array_2 = (2, 4)
Output: 2

Example 3

Input: @array_1 = (1, 2, 3, 4)
       @array_2 = (5, 6, 7, 8)
Output: -1
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 4th May 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def mc(arr1: tuple[int], arr2: tuple[int]) -> int:
    cmn = set(arr1) & set(arr2)
    return min(cmn) if len(cmn) > 0 else -1

import unittest

class TestMc(unittest.TestCase):
    def test(self):
        for (arr1,arr2), otpt in {
                ((1, 2, 3, 4),(3, 4, 5, 6)): 3,
                ((1, 2, 3),(2, 4)): 2,
                ((1, 2, 3, 4),(5, 6, 7, 8)): -1,
                }.items():
            self.assertEqual(mc(arr1,arr2),otpt)

unittest.main()
