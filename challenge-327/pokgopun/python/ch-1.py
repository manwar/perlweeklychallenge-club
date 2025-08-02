### https://theweeklychallenge.org/blog/perl-weekly-challenge-327/
"""

Task 1: Missing Integers

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of n integers.

   Write a script to find all the missing integers in the range 1..n in
   the given array.

Example 1

Input: @ints = (1, 2, 1, 3, 2, 5)
Output: (4, 6)

The given array has 6 elements.
So we are looking for integers in the range 1..6 in the given array.
The missing integers: (4, 6)

Example 2

Input: @ints = (1, 1, 1)
Output: (2, 3)

Example 3

Input: @ints = (2, 2, 1)
Output: (3)

Task 2: MAD
"""
### solution by pokgopun@gmail.com

def mi(ints: tuple[int]) -> tuple[int]:
    return tuple(set(range(1,len(ints)+1)) - set(ints))

import unittest

class TestMi(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (1, 2, 1, 3, 2, 5): (4, 6),
                (1, 1, 1): (2, 3),
                (2, 2, 1): (3,),
                }.items():
            self.assertEqual(mi(inpt),otpt)

unittest.main()


