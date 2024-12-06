### https://theweeklychallenge.org/blog/perl-weekly-challenge-295/
"""

Task 1: Word Break

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str, and list of words, @words.

   Write a script to return true or false whether the given string can be
   segmented into a space separated sequence of one or more words from the
   given list.

Example 1

Input: $str = 'weeklychallenge', @words = ("challenge", "weekly")
Output: true

Example 2

Input: $str = "perlrakuperl", @words = ("raku", "perl")
Output: true

Example 3

Input: $str = "sonsanddaughters", @words = ("sons", "sand", "daughters")
Output: false

Task 2: Jump Game
"""
### solution by pokgopun@gmail.com

from typing import Tuple

def wb(string: str, words: Tuple[str]) -> bool:
    for w in words:
        if string.find(w) == -1:
            return False
        string = string.replace(w,"")
    return string == ""

import unittest

class TestWc(unittest.TestCase):
    def test(self):
        for string, words, otpt in (
                ('weeklychallenge', ("challenge", "weekly"), True),
                ("perlrakuperl", ("raku", "perl"), True),
                ("sonsanddaughters", ("sons", "sand", "daughters"), False),
                ):
            self.assertEqual(wb(string,words), otpt)

unittest.main()
