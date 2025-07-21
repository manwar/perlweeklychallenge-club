### https://theweeklychallenge.org/blog/perl-weekly-challenge-331/
"""

Task 1: Last Word

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string.

   Write a script to find the length of last word in the given string.

Example 1

Input: $str = "The Weekly Challenge"
Output: 9

Example 2

Input: $str = "   Hello   World    "
Output: 5

Example 3

Input: $str = "Let's begin the fun"
Output: 3

Task 2: Buddy Strings
"""
### solution by pokgopun@gmail.com

import re

def lw(string: str) -> str:
    m = re.search(r'(\S+)\s*$', string)
    return m.end(1) - m.start(1)

import unittest

class TestLw(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "The Weekly Challenge": 9,
                "   Hello   World    ": 5,
                "Let's begin the fun": 3,
                }.items():
            self.assertEqual(lw(inpt),otpt)

unittest.main()
