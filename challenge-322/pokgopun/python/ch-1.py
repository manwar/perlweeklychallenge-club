### https://theweeklychallenge.org/blog/perl-weekly-challenge-322/
"""

Task 1: String Format

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string and a positive integer.

   Write a script to format the string, removing any dashes, in groups of
   size given by the integer. The first group can be smaller than the
   integer but should have at least one character. Groups should be
   separated by dashes.

Example 1

Input: $str = "ABC-D-E-F", $i = 3
Output: "ABC-DEF"

Example 2

Input: $str = "A-BC-D-E", $i = 2
Output: "A-BC-DE"

Example 3

Input: $str = "-A-B-CD-E", $i = 4
Output: "A-BCDE"

Task 2: Rank Array
"""
### solution by pokgopun@gmail.com

def sf(string: str, n: int) -> str:
    slt = ""
    i = len(string)
    l = 0
    while i > 0:
        i -= 1
        if string[i] == "-":
            continue
        if l < n:
            slt = string[i] + slt
            l += 1
        else:
            slt = string[i] + "-" + slt
            l = 1
    return slt

import unittest

class TestSf(unittest.TestCase):
    def test(self):
        for (string,n), otpt in {
                ("ABC-D-E-F", 3):"ABC-DEF",
                ("A-BC-D-E", 2): "A-BC-DE",
                ("-A-B-CD-E", 4): "A-BCDE",
                }.items():
            self.assertEqual(sf(string,n),otpt)

unittest.main()
