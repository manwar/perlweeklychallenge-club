### https://theweeklychallenge.org/blog/perl-weekly-challenge-291/
"""

Task 1: Middle Index

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find the leftmost middle index (MI) i.e. the smallest
   amongst all the possible ones.

     A middle index is an index where ints[0] + ints[1] + … + ints[MI-1]
     == ints[MI+1] + ints[MI+2] + … + ints[ints.length-1].

If MI == 0, the left side sum is considered to be 0. Similarly,
if MI == ints.length - 1, the right side sum is considered to be 0.

   Return the leftmost MI that satisfies the condition, or -1 if there is
   no such index.

Example 1

Input: @ints = (2, 3, -1, 8, 4)
Output: 3

The sum of the numbers before index 3 is: 2 + 3 + -1 = 4
The sum of the numbers after index 3 is: 4 = 4

Example 2

Input: @ints = (1, -1, 4)
Output: 2

The sum of the numbers before index 2 is: 1 + -1 = 0
The sum of the numbers after index 2 is: 0

Example 3

Input: @ints = (2, 5)
Output: -1

There is no valid MI.

Task 2: Poker Hand Rankings
"""
### solution by pokgopun@gmail.com

def mi(ints: tuple):
    for i in range(len(ints)):
        if sum(ints[:i])==sum(ints[i+1:]):
            return i
    return -1

import unittest

class TestMi(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (2, 3, -1, 8, 4): 3,
                (1, -1, 4): 2,
                (2, 5): -1
                }.items():
            self.assertEqual(mi(inpt),otpt)

unittest.main()
