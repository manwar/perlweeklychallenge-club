### https://theweeklychallenge.org/blog/perl-weekly-challenge-332/
"""

Task 1: Binary Date

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a date in the format YYYY-MM-DD.

   Write a script to convert it into binary date.

Example 1

Input: $date = "2025-07-26"
Output: "11111101001-111-11010"

Example 2

Input: $date = "2000-02-02"
Output: "11111010000-10-10"

Example 3

Input: $date = "2024-12-31"
Output: "11111101000-1100-11111"

Task 2: Odd Letters
"""
### solution by pokgopun@gmail.com

def bd(string: str) -> str:
    return "-".join(bin(int(e))[2:] for e in string.split("-"))

import unittest

class TestBd(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "2025-07-26": "11111101001-111-11010",
                "2000-02-02": "11111010000-10-10",
                "2024-12-31": "11111101000-1100-11111",
                }.items():
            self.assertEqual(bd(inpt),otpt)

unittest.main()
