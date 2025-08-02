### https://theweeklychallenge.org/blog/perl-weekly-challenge-329/
"""

Task 1: Counter Integers

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing only lower case English letters and
   digits.

   Write a script to replace every non-digit character with a space and
   then return all the distinct integers left.

Example 1

Input: $str = "the1weekly2challenge2"
Output: 1, 2

2 is appeared twice, so we count it one only.

Example 2

Input: $str = "go21od1lu5c7k"
Output: 21, 1, 5, 7

Example 3

Input: $str = "4p3e2r1l"
Output: 4, 3, 2, 1

Task 2: Nice String
"""
### solution by pokgopun@gmail.com

import re

def ci(string: str) -> tuple[int]:
    seen = dict()
    return tuple(seen.setdefault(d,int(d)) for d in re.sub(r"\D+", " ", string).strip().split()
            if seen.get(d) == None)

import unittest

class TestCi(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                "the1weekly2challenge2": (1, 2),
                "go21od1lu5c7k": (21, 1, 5, 7),
                "4p3e2r1l": (4, 3, 2, 1),
                }.items():
            self.assertEqual(ci(inpt), otpt)

unittest.main()
