### https://theweeklychallenge.org/blog/perl-weekly-challenge-311/
"""

Task 1: Upper Lower

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string consists of english letters only.

   Write a script to convert lower case to upper and upper case to lower
   in the given string.

Example 1

Input: $str = "pERl"
Output: "PerL"

Example 2

Input: $str = "rakU"
Output: "RAKu"

Example 3

Input: $str = "PyThOn"
Output: "pYtHoN"

Task 2: Group Digit Sum
"""
### solution by pokgopun@gmail.com

def ul(string: str) -> str:
    return "".join( e.upper() if e.islower() else e.lower() for e in string )

import unittest

class TestUl(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "pERl": "PerL",
                "rakU": "RAKu",
                "PyThOn": "pYtHoN",
                }.items():
            self.assertEqual(ul(inpt),otpt)

unittest.main()
