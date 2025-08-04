### https://theweeklychallenge.org/blog/perl-weekly-challenge-333/
"""

Task 2: Duplicate Zeros

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to duplicate each occurrence of zero, shifting the
   remaining elements to the right. The elements beyond the length of the
   original array are not written.

Example 1

Input: @ints = (1, 0, 2, 3, 0, 4, 5, 0)
Output: (1, 0, 0, 2, 3, 0, 0, 4)

Each zero is duplicated.
Elements beyond the original length (like 5 and last 0) are discarded.

Example 2

Input: @ints = (1, 2, 3)
Output: (1, 2, 3)

No zeros exist, so the array remains unchanged.

Example 3

Input: @ints = (1, 2, 3, 0)
Output: (1, 2, 3, 0)

Example 4

Input: @ints = (0, 0, 1, 2)
Output: (0, 0, 0, 0)

Example 5

Input: @ints = (1, 2, 0, 3, 4)
Output: (1, 2, 0, 0, 3)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 10th August
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def dz(ints: tuple[int]) -> tuple[int]:
    ints = list(ints)
    l = len(ints) - 1
    i = 0
    while i < l:
        if ints[i] == 0:
            ints.insert(i,0)
            i += 1
        i += 1
    return tuple(ints[:l+1])

import unittest

class TestDz(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (1, 0, 2, 3, 0, 4, 5, 0): (1, 0, 0, 2, 3, 0, 0, 4),
                (1, 2, 3): (1, 2, 3),
                (1, 2, 3, 0): (1, 2, 3, 0),
                (0, 0, 1, 2): (0, 0, 0, 0),
                (1, 2, 0, 3, 4): (1, 2, 0, 0, 3),
                }.items():
            self.assertEqual(dz(inpt),otpt)

unittest.main()
