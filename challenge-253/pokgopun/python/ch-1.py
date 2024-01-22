### https://theweeklychallenge.org/blog/perl-weekly-challenge-253/
"""

Task 1: Split Strings

Submitted by: [43]Mohammad S Anwar
     __________________________________________________________________

   You are given an array of strings and a character separator.

   Write a script to return all words separated by the given character
   excluding empty string.

Example 1

Input: @words = ("one.two.three","four.five","six")
       $separator = "."
Output: "one","two","three","four","five","six"

Example 2

Input: @words = ("$perl$$", "$$raku$")
       $separator = "$"
Output: "perl","raku"

Task 2: Weakest Row
"""
### solution by pokgopun@gmail.com

from itertools import chain

def splitString(wrd: tuple, sep: str):
    return tuple(
            e for e in chain.from_iterable(
                w.split(sep) for w in wrd
                ) if e
            )

import unittest

class TestSplitString(unittest.TestCase):
    def test(self):
        for (wrd,sep),otpt in {
                (("one.two.three","four.five","six"), "."): ("one","two","three","four","five","six"),
                (("$perl$$", "$$raku$"), "$"): ("perl","raku"),
                }.items():
            self.assertEqual(splitString(wrd,sep),otpt)

unittest.main()

