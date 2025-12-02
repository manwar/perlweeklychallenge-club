### https://theweeklychallenge.org/blog/perl-weekly-challenge-350/
"""

Task 1: Good Substrings

Submitted by: [51]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string.

   Write a script to return the number of good substrings of length three
   in the given string.

     A string is good if there are no repeated characters.

Example 1

Input: $str = "abcaefg"
Output: 5

Good substrings of length 3: abc, bca, cae, aef and efg

Example 2

Input: $str = "xyzzabc"
Output: 3

Good substrings of length 3: "xyz", "zab" and "abc"

Example 3

Input: $str = "aababc"
Output: 1

Good substrings of length 3: "abc"

Example 4

Input: $str = "qwerty"
Output: 4

Good substrings of length 3: "qwe", "wer", "ert" and "rty"

Example 5

Input: $str = "zzzaaa"
Output: 0

Task 2: Shuffle Pairs
"""
### solution by pokgopun@gmail.com

def gs(string: str) -> int:
    n = 3
    c = 0
    l = len(string)
    for i in range(l-n+1):
        if len(set(string[i:i+n])) == n:
            c += 1
    return c

import unittest

class TestGs(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "abcaefg": 5,
                "xyzzabc": 3,
                "aababc": 1,
                "qwerty": 4,
                "zzzaaa": 0,
                }.items():
            self.assertEqual(gs(inpt),otpt)

unittest.main()
