### https://theweeklychallenge.org/blog/perl-weekly-challenge-309/
"""

Task 2: Min Diff

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the minimum difference between any two elements.

Example 1

Input: @ints = (1, 5, 8, 9)
Output: 1

1, 5 => 5 - 1 => 4
1, 8 => 8 - 1 => 7
1, 9 => 9 - 1 => 8
5, 8 => 8 - 5 => 3
5, 9 => 9 - 5 => 4
8, 9 => 9 - 8 => 1

Example 2

Input: @ints = (9, 4, 1, 7)
Output: 2

9, 4 => 9 - 4 => 5
9, 1 => 9 - 1 => 8
9, 7 => 9 - 7 => 2
4, 1 => 4 - 1 => 3
4, 7 => 7 - 4 => 3
1, 7 => 7 - 1 => 6
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 23^rd February
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def minDiff(ints: tuple[int]) -> int:
    mn = None
    l = len(ints)
    for i in range(l-1):
        for j in range(i+1,l):
            mni = abs(ints[i] - ints[j])
            if mn is None or mn > mni:
                mn = mni
    return mn

import unittest

class TestMinDiff(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (1, 5, 8, 9): 1,
                (9, 4, 1, 7): 2,
                }.items():
            self.assertEqual(minDiff(inpt), otpt)

unittest.main()


