### https://theweeklychallenge.org/blog/perl-weekly-challenge-258/
"""

Task 1: Count Even Digits Number

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a array of positive integers, @ints.

   Write a script to find out how many integers have even number of
   digits.

Example 1

Input: @ints = (10, 1, 111, 24, 1000)
Output: 3

There are 3 integers having even digits i.e. 10, 24 and 1000.

Example 2

Input: @ints = (111, 1, 11111)
Output: 0

Example 3

Input: @ints = (2, 8, 1024, 256)
Output: 1

Task 2: Sum of Values
"""
### solution by pokgopun@gmail.com

def CEDN(ints: tuple):
    return sum(
            len(str(e)) % 2 == 0 for e in ints
            )

import unittest

class TestCEDN(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (10, 1, 111, 24, 1000): 3,
                (111, 1, 11111): 0,
                (2, 8, 1024, 256): 1,
                }.items():
            self.assertEqual(CEDN(inpt),otpt)

unittest.main()
