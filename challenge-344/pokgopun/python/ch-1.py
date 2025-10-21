### https://theweeklychallenge.org/blog/perl-weekly-challenge-344/
"""

Task 1: Array Form Compute

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints and an integer, $x.

   Write a script to add $x to the integer in the array-form.

     The array form of an integer is a digit-by-digit representation
     stored as an array, where the most significant digit is at the 0th
     index.

Example 1

Input: @ints = (1, 2, 3, 4), $x = 12
Output: (1, 2, 4, 6)

Example 2

Input: @ints = (2, 7, 4), $x = 181
Output: (4, 5, 5)

Example 3

Input: @ints = (9, 9, 9), $x = 1
Output: (1, 0, 0, 0)

Example 4

Input: @ints = (1, 0, 0, 0, 0), $x = 9999
Output: (1, 9, 9, 9, 9)

Example 5

Input: @ints = (0), $x = 1000
Output: (1, 0, 0, 0)

Task 2: Array Formation
"""
### solution by pokgopun@gmail.com

def afc(ints: tuple[int], x: int) -> tuple[int]:
    return tuple(
            int(e) for e in str(int("".join(str(n) for n in ints)) + x)
            )

import unittest

class TestAfc(unittest.TestCase):
    def test(self):
        for (ints, x), otpt in {
                ((1, 2, 3, 4), 12): (1, 2, 4, 6),
                ((2, 7, 4), 181): (4, 5, 5),
                ((9, 9, 9), 1): (1, 0, 0, 0),
                ((1, 0, 0, 0, 0), 9999): (1, 9, 9, 9, 9),
                ((0,), 1000): (1, 0, 0, 0),
                }.items():
            self.assertEqual(afc(ints,x), otpt)

unittest.main()
