### https://theweeklychallenge.org/blog/perl-weekly-challenge-282/
"""

Task 1: Good Integer

Submitted by: [57]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a positive integer, $int, having 3 or more digits.

   Write a script to return the Good Integer in the given integer or -1 if
   none found.

     A good integer is exactly three consecutive matching digits.

Example 1

Input: $int = 12344456
Output: "444"

Example 2

Input: $int = 1233334
Output: -1

Example 3

Input: $int = 10020003
Output: "000"

Task 2: Changing Keys
"""
### solution by pokgopun@gmail.com

def gi(num: int):
    count = 0
    digit = ""
    for d in str(num):
        if digit == d:
            count += 1
        else:
            if count == 3:
                return digit*3
            digit = d
            count = 1
    return -1

import unittest

class TestGi(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                12344456: "444",
                1233334: -1,
                10020003: "000",
                }.items():
            self.assertEqual(gi(inpt),otpt)

unittest.main()
