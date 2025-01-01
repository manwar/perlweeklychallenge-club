### https://theweeklychallenge.org/blog/perl-weekly-challenge-302/
"""

Task 2: Step by Step

Submitted by: [69]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the minimum positive start value such that step
   by step sum is never less than one.

Example 1

Input: @ints = (-3, 2, -3, 4, 2)
Output: 5

For start value 5.
5 + (-3) = 2
2 + (+2) = 4
4 + (-3) = 1
1 + (+4) = 5
5 + (+2) = 7

Example 2

Input: @ints = (1, 2)
Output: 1

Example 3

Input: @ints = (1, -2, -3)
Output: 5
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 5^th January
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from typing import Tuple

def sbs(ints: Tuple[int]) -> int:
    l = len(ints)
    for idx in range(l-1,-1,-1):
        if ints[idx] < 0:
            break
    if idx == 0 and ints[idx] >= 0:
        return 1
    star = 1 - ints[idx]
    for i in range(idx-1,-1,-1):
        star -= ints[i]
    return star

import unittest

class TestSbs(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (-3, 2, -3, 4, 2): 5,
                (1, 2): 1,
                (1, -2, -3): 5,
                }.items():
            self.assertEqual(sbs(inpt),otpt)

unittest.main()
