### https://theweeklychallenge.org/blog/perl-weekly-challenge-329/
"""

Task 2: Nice String

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string made up of lower and upper case English letters
   only.

   Write a script to return the longest substring of the give string which
   is nice. A string is nice if, for every letter of the alphabet that the
   string contains, it appears both in uppercase and lowercase.

Example 1

Input: $str = "YaaAho"
Output: "aaA"

Example 2

Input: $str = "cC"
Output: "cC"

Example 3

Input: $str = "A"
Output: ""

No nice string found.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 13th July 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def ns(string: str) -> str:
    start = 0
    nice = ""
    for i in range(1,len(string)):
        if string[i].lower() == string[i-1].lower():
            continue
        else:
            cdd = string[start:i]
            if len(set(cdd)) > 1 and len(cdd) > len(nice):
                nice = cdd
            start = i
    else:
        cdd = string[start:]
        if len(set(cdd)) > 1 and len(cdd) > len(nice):
            nice = cdd
    return nice

import unittest

class TestNs(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "YaaAho": "aaA",
                "YaaAhoooo": "aaA",
                "YaaAhoOOo": "oOOo",
                "YaaAhooO": "aaA",
                "cC": "cC",
                "cc": "",
                "A": "",
                }.items():
            self.assertEqual(ns(inpt),otpt)

unittest.main()
