### https://theweeklychallenge.org/blog/perl-weekly-challenge-281/
"""

Task 1: Check Color

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given coordinates, a string that represents the coordinates of
   a square of the chessboard as shown below:

   Week_281_Task_1

   Write a script to return true if the square is light, and false if the
   square is dark.

Example 1

Input: $coordinates = "d3"
Output: true

Example 2

Input: $coordinates = "g5"
Output: false

Example 3

Input: $coordinates = "e6"
Output: true

Task 2: Knight’s Move
"""
### solution by pokgopun@gmail.com

def checkColor(string: str):
    return sum(
            ord(c) for c in string
            ) % 2 == 1

import unittest

class TestCheckColor(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "d3": True,
                "g5": False,
                "e6": True,
                }.items():
            self.assertEqual(checkColor(inpt),otpt)

unittest.main()
