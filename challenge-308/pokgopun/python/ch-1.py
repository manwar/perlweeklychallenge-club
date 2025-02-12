### https://theweeklychallenge.org/blog/perl-weekly-challenge-308/
"""

Task 1: Count Common

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two array of strings, @str1 and @str2.

   Write a script to return the count of common strings in both arrays.

Example 1

Input: @str1 = ("perl", "weekly", "challenge")
       @str2 = ("raku", "weekly", "challenge")
Output: 2

Example 2

Input: @str1 = ("perl", "raku", "python")
       @str2 = ("python", "java")
Output: 1

Example 3

Input: @str1 = ("guest", "contribution")
       @str2 = ("fun", "weekly", "challenge")
Output: 0

Task 2: Decode XOR
"""
### solution by pokgopun@gmail.com

def countCommon(strs1: tuple[str], strs2: tuple[str]) -> int:
    return len( set(strs1) & set(strs2) )

import unittest

class TestCountCommon(unittest.TestCase):
    def test(self):
        for (strs1, strs2), otpt in {
                (("perl", "weekly", "challenge"),("raku", "weekly", "challenge")): 2,
                (("perl", "raku", "python"),("python", "java")): 1,
                (("guest", "contribution"),("fun", "weekly", "challenge")): 0,
                }.items():
            self.assertEqual(countCommon(strs1,strs2), otpt)

unittest.main()
