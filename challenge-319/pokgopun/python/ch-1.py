### https://theweeklychallenge.org/blog/perl-weekly-challenge-319/
"""

Task 1: Word Count

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of words containing alphabetic characters only.

   Write a script to return the count of words either starting with a
   vowel or ending with a vowel.

Example 1

Input: @list = ("unicode", "xml", "raku", "perl")
Output: 2

The words are "unicode" and "raku".

Example 2

Input: @list = ("the", "weekly", "challenge")
Output: 2

Example 3

Input: @list = ("perl", "python", "postgres")
Output: 0

Task 2: Minimum Common
"""
### solution by pokgopun@gmail.com

def wc(words: tuple[str]) -> int:
    v = "eaiou"
    return sum(1 for w in words if w[0].lower() in v or w[-1].lower() in v)

import unittest

class TestWc(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                ("unicode", "xml", "raku", "perl"): 2,
                ("the", "weekly", "challenge"): 2,
                ("perl", "python", "postgres"): 0,
                }.items():
            self.assertEqual(wc(inpt), otpt)

unittest.main()
