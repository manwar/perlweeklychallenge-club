### https://theweeklychallenge.org/blog/perl-weekly-challenge-273/
"""

Task 2: B After A

Submitted by: [53]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str.

   Write a script to return true if there is at least one b, and no a
   appears after the first b.

Example 1

Input: $str = "aabb"
Output: true

Example 2

Input: $str = "abab"
Output: false

Example 3

Input: $str = "aaa"
Output: false

Example 4

Input: $str = "bbb"
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 16th June 2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def bAfterA(string):
    i = string.find("b")
    if i == -1:
        return False
    return string[i+1:].find("a") == -1

import unittest

class TestBAfterA(unittest.TestCase):
    def test(self):
        for string, otpt in {
                "aabb": True,
                "abab": False,
                "aaa": False,
                "bbb": True,
                }.items():
            self.assertEqual(bAfterA(string),otpt)

unittest.main()
