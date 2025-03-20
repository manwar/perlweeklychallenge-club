### https://theweeklychallenge.org/blog/perl-weekly-challenge-313/
"""

Task 2: Reverse Letters

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string.

   Write a script to reverse only the alphabetic characters in the string.

Example 1

Input: $str = "p-er?l"
Output: "l-re?p"

Example 2

Input: $str = "wee-k!L-y"
Output: "yLk-e!e-w"

Example 3

Input: $str = "_c-!h_all-en!g_e"
Output: "_e-!g_nel-la!h_c"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 23rd March
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def rl(string: str) -> str:
    ltrPos = tuple(i for i in range(len(string)) if string[i].isalpha()) ### positions of letters
    l = len(ltrPos)
    rltrs = tuple(string[ltrPos[i]] for i in range(l-1,-1,-1)) ### letters in reversed order
    chars = list(string) ### convert string to list so it can have the letters replaced with their reversed version
    for i in range(l): ### do the replacement
        chars[ltrPos[i]] = rltrs[i]
    return "".join(chars) ### compose the string back

import unittest

class TestRl(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "p-er?l": "l-re?p",
                "wee-k!L-y": "yLk-e!e-w",
                "_c-!h_all-en!g_e": "_e-!g_nel-la!h_c",
                }.items():
            self.assertEqual(rl(inpt),otpt)

unittest.main()
