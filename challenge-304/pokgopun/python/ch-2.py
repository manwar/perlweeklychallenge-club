### https://theweeklychallenge.org/blog/perl-weekly-challenge-304/
"""

Task 2: Maximum Average

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints and an integer, $n which is
   less than or equal to total elements in the given array.

   Write a script to find the contiguous subarray whose length is the
   given integer, $n, and has the maximum average. It should return the
   average.

Example 1

Input: @ints = (1, 12, -5, -6, 50, 3), $n = 4
Output: 12.75

Subarray: (12, -5, -6, 50)
Average: (12 - 5 - 6 + 50) / 4 = 12.75

Example 2

Input: @ints = (5), $n = 1
Output: 5
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 19^th January
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from typing import Tuple

def ma(ints: Tuple[int], n: int) -> float:
    sm = sum(ints[:n])
    mx = sm 
    for i in range(len(ints)-n):
        sm += ints[i+n] - ints[i]
        if sm > mx:
            mx = sm
    return mx / n

import unittest

class TestMa(unittest.TestCase):
    def test(self):
        for (ints,n),otpt in {
                ((1, 12, -5, -6, 50, 3), 4): 12.75,
                ((5,), 1): 5,
                }.items():
            self.assertEqual(ma(ints,n),otpt)

unittest.main()
