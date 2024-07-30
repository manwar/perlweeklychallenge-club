### https://theweeklychallenge.org/blog/perl-weekly-challenge-280/
"""

Task 1: Twice Appearance

Submitted by: [53]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, containing lowercase English letters
   only.

   Write a script to print the first letter that appears twice.

Example 1

Input: $str = "acbddbca"
Output: "d"

Example 2

Input: $str = "abccd"
Output: "c"

Example 3

Input: $str = "abcdabbb"
Output: "a"

Task 2: Count Asterisks
"""
### solution by pokgopun@gmail.com

def ta(string: str):
    return min(
            e for e in (
                (string[t[0]+1:].find(t[1]),t[1]) for t in (
                    (string.find(c),c) for c in set(string)
                    )
                ) if e[0] >= 0
            )[1]

import unittest

class TestTa(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
            #    "acbddbca": "d",
                "abccd": "c",
                "abcdabbb": "a",
                }.items():
            self.assertEqual(ta(inpt),otpt)

unittest.main()
