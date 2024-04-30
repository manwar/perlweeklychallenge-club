### https://theweeklychallenge.org/blog/perl-weekly-challenge-267/
"""

Task 1: Product Sign

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of @ints.

   Write a script to find the sign of product of all integers in the given
   array. The sign is 1 if the product is positive, -1 if the product is
   negative and 0 if product is zero.

Example 1

Input: @ints = (-1, -2, -3, -4, 3, 2, 1)
Output: 1

The product -1 x -2 x -3 x -4 x 3 x 2 x 1 => 144 > 0

Example 2

Input: @ints = (1, 2, 0, -2, -1)
Output: 0

The product 1 x 2 x 0 x -2 x -1 => 0

Example 3

Input: @ints = (-1, -1, 1, -1, 2)
Output: -1

The product -1 x -1 x 1 x -1 x 2 => -2 < 0

Task 2: Line Counts
"""
### solution by pokgopun@gmail.com

def productSign(ints: tuple):
    res = 1
    for i in range(len(ints)):
        if ints[i]==0:
            return 0
        elif ints[i] < 0:
            res *= -1
    return res

import unittest

class TestProductSign(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                (-1, -2, -3, -4, 3, 2, 1): 1,
                (1, 2, 0, -2, -1): 0,
                (-1, -1, 1, -1, 2): -1,
                }.items():
            self.assertEqual(productSign(inpt),otpt)

unittest.main()
