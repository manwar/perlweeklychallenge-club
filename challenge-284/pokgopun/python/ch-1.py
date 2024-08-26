### https://theweeklychallenge.org/blog/perl-weekly-challenge-284/
"""

Task 1: Lucky Integer

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the lucky integer if found otherwise return -1.
   If there are more than one then return the largest.

     A lucky integer is an integer that has a frequency in the array
     equal to its value.

Example 1

Input: @ints = (2, 2, 3, 4)
Output: 2

Example 2

Input: @ints = (1, 2, 2, 3, 3, 3)
Output: 3

Example 3

Input: @ints = (1, 1, 1, 3)
Output: -1

Task 2: Relative Sort
"""
### solution by pokgopun@gmail.com

def li(ints: tuple):
    return max(
            e if e==ints.count(e) else -1 for e in ints
            )

import unittest

class TestLi(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (2, 2, 3, 4): 2,
                (1, 2, 2, 3, 3, 3): 3,
                (1, 1, 1, 3): -1,
                }.items():
            self.assertEqual(li(inpt),otpt)

unittest.main()
