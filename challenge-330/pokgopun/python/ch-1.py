### https://theweeklychallenge.org/blog/perl-weekly-challenge-330/
"""

Task 1: Clear Digits

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing only lower case English letters and
   digits.

   Write a script to remove all digits by removing the first digit and the
   closest non-digit character to its left.

Example 1

Input: $str = "cab12"
Output: "c"

Round 1: remove "1" then "b" => "ca2"
Round 2: remove "2" then "a" => "c"

Example 2

Input: $str = "xy99"
Output: ""

Round 1: remove "9" then "y" => "x9"
Round 2: remove "9" then "x" => ""

Example 3

Input: $str = "pa1erl"
Output: "perl"

Task 2: Title Capital
"""
### solution by pokgopun@gmail.com

import re

def cd(string: str) -> str:
    while True:
        s = re.sub(r'([a-z])([^a-z]*?)(\d)',r'\2',string)
        if s == string:
            break
        string = s
    return s

import unittest

class TestCd(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "cab12": "c",
                "xy99": "",
                "pa1erl": "perl",
                }.items():
            self.assertEqual(cd(inpt),otpt)

unittest.main()
