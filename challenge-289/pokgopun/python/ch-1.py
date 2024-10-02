### https://theweeklychallenge.org/blog/perl-weekly-challenge-289/
"""

Task 1: Third Maximum

Submitted by: [50]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the third distinct maximum in the given array.
   If third maximum doesn’t exist then return the maximum number.

Example 1

Input: @ints = (5, 6, 4, 1)
Output: 4

The first distinct maximum is 6.
The second distinct maximum is 5.
The third distinct maximum is 4.

Example 2

Input: @ints = (4, 5)
Output: 5

In the given array, the third maximum doesn't exist therefore returns the maximu
m.

Example 3

Input: @ints =  (1, 2, 2, 3)
Output: 1

The first distinct maximum is 3.
The second distinct maximum is 2.
The third distinct maximum is 1.

Task 2: Jumbled Letters
"""
### solution by pokgopun@gmail.com

def thirdMax(ints: tuple):
    mx = sorted(set(ints),reverse=True)
    if len(mx) > 2:
        return mx[2]
    return mx[0]

import unittest

class TestThirdMax(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (5, 6, 4, 1): 4,
                (4, 5): 5,
                (1, 2, 2, 3): 1,
                }.items():
            self.assertEqual(thirdMax(inpt),otpt)

unittest.main()


