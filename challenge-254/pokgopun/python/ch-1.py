### https://theweeklychallenge.org/blog/perl-weekly-challenge-254/
"""

Task 1: Three Power

Submitted by: [47]Mohammad S Anwar
     __________________________________________________________________

   You are given a positive integer, $n.

   Write a script to return true if the given integer is a power of three
   otherwise return false.

Example 1

Input: $n = 27
Output: true

27 = 3 ^ 3

Example 2

Input: $n = 0
Output: true

0 = 0 ^ 3

Example 3

Input: $n = 6
Output: false

Task 2: Reverse Vowels
"""
### solution by pokgopun@gmail.com

def is3power(n: int):
    return n==int(n**(1/3))**3

import unittest

class TestIs3power(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                27: True,
                0: True,
                6: False,
                }.items():
            self.assertEqual(is3power(inpt),otpt)

unittest.main()
