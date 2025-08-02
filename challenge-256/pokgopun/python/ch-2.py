### https://theweeklychallenge.org/blog/perl-weekly-challenge-256/
"""

Task 2: Merge Strings

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two strings, $str1 and $str2.

   Write a script to merge the given strings by adding in alternative
   order starting with the first string. If a string is longer than the
   other then append the remaining at the end.

Example 1

Input: $str1 = "abcd", $str2 = "1234"
Output: "a1b2c3d4"

Example 2

Input: $str1 = "abc", $str2 = "12345"
Output: "a1b2c345"

Example 3

Input: $str1 = "abcde", $str2 = "123"
Output: "a1b2c3de"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 18th February
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from itertools import zip_longest,chain

def mergeStrings(str1, str2):
    return "".join(
            chain.from_iterable(
                zip_longest(str1,str2,fillvalue="")
                )
            )

import unittest

class TestMergeStrings(unittest.TestCase):
    def test(self):
        for (str1,str2), otpt in {
                ("abcd","1234"): "a1b2c3d4",
                ("abc", "12345"): "a1b2c345",
                ("abcde", "123"): "a1b2c3de",
                }.items():
            self.assertEqual(mergeStrings(str1,str2),otpt)

unittest.main()
