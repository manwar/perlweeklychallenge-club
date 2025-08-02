### https://theweeklychallenge.org/blog/perl-weekly-challenge-316/
"""

Task 2: Subsequence

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two string.

   Write a script to find out if one string is a subsequence of another.
A subsequence of a string is a new string that is formed from the original strin
g
by deleting some (can be none)  of the characters without disturbing the relativ
e
positions of the remaining characters.

Example 1

Input: $str1 = "uvw", $str2 = "bcudvew"
Output: true

Example 2

Input: $str1 = "aec", $str2 = "abcde"
Output: false

Example 3

Input: $str1 = "sip", $str2 = "javascript"
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 13th April
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

import re

def ss(str1: str, str2: str) -> bool:
    return bool(re.search(".*".join(tuple(str1)),str2))

import unittest

class TestSs(unittest.TestCase):
    def test(self):
        for (str1, str2), otpt in {
                ("uvw", "bcudvew"): True,
                ("aec", "abcde"): False,
                ("sip", "javascript"): True,
                }.items():
            self.assertEqual(ss(str1,str2), otpt)

unittest.main()
