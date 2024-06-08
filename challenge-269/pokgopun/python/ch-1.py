### https://theweeklychallenge.org/blog/perl-weekly-challenge-269/
"""

Task 1: Bitwise OR

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of positive integers, @ints.

   Write a script to find out if it is possible to select two or more
   elements of the given array such that the bitwise OR of the selected
   elements has atlest one trailing zero in its binary representation.

Example 1

Input: @ints = (1, 2, 3, 4, 5)
Output: true

Say, we pick 2 and 4, thier bitwise OR is 6. The binary representation of 6 is 1
10.
Return true since we have one trailing zero.

Example 2

Input: @ints = (2, 3, 8, 16)
Output: true

Say, we pick 2 and 8, thier bitwise OR is 10. The binary representation of 10 is
 1010.
Return true since we have one trailing zero.

Example 3

Input: @ints = (1, 2, 5, 7, 9)
Output: false

Task 2: Distribute Elements
"""
### solution by pokgopun@gmail.com


def bwo(ints: tuple):
    c = 0
    for i in ints:
        if i % 2 == 0:
            c += 1
        if c > 1:
            return True
    return False

import unittest

class TestBwo(unittest.TestCase):
    def test(self):
        for ints, ans in {
                (1, 2, 3, 4, 5): True,
                (2, 3, 8, 16): True,
                (1, 2, 5, 7, 9): False,
                }.items():
            self.assertEqual(bwo(ints),ans)

unittest.main()
