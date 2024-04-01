### https://theweeklychallenge.org/blog/perl-weekly-challenge-262/
"""

Task 1: Max Positive Negative

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to return the maximum number of either positive or
   negative integers in the given array.

Example 1

Input: @ints = (-3, 1, 2, -1, 3, -2, 4)
Output: 4

Count of positive integers: 4
Count of negative integers: 3
Maximum of count of positive and negative integers: 4

Example 2

Input: @ints = (-1, -2, -3, 1)
Output: 3

Count of positive integers: 1
Count of negative integers: 3
Maximum of count of positive and negative integers: 3

Example 3

Input: @ints = (1,2)
Output: 2

Count of positive integers: 2
Count of negative integers: 0
Maximum of count of positive and negative integers: 2

Task 2: Count Equal Divisible
"""
### solution by pokgopun@gmail.com

def mpn(ints: tuple):
    n = sum(1 for i in ints if i < 0)
    return max(n, len(ints) - n)

import unittest

class TestMpn(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (-3, 1, 2, -1, 3, -2, 4): 4,
                (-1, -2, -3, 1): 3,
                (1,2): 2,
                }.items():
            self.assertEqual(mpn(inpt),otpt)

unittest.main()
