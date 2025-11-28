### https://theweeklychallenge.org/blog/perl-weekly-challenge-349/
"""

Task 1: Power String

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string.

   Write a script to return the power of the given string.

     The power of the string is the maximum length of a non-empty
     substring that contains only one unique character.

Example 1

Input: $str = "textbook"
Output: 2

Breakdown: "t", "e", "x", "b", "oo", "k"
The longest substring with one unique character is "oo".

Example 2

Input: $str = "aaaaa"
Output: 5

Example 3

Input: $str = "hoorayyy"
Output: 3

Breakdown: "h", "oo", "r", "a", "yyy"
The longest substring with one unique character is "yyy".

Example 4

Input: $str = "x"
Output: 1

Example 5

Input: $str = "aabcccddeeffffghijjk"
Output: 4

Breakdown: "aa", "b", "ccc", "dd", "ee", "ffff", "g", "h", "i", "jj", "k"
The longest substring with one unique character is "ffff".

Task 2: Meeting Point
"""
### solution by pokgopun@gmail.com

def ps(string: str) -> int:
    prv = string[0]
    dct = {prv:1}
    mx = 1
    for c in string[1:]:
        dct[c] = dct.get(c,0) + 1
        if c != prv:
            dct[prv] = 0
            prv = c
        if mx < dct[c]:
            mx = dct[c]
    return mx

import unittest

class TestPs(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "textbook": 2,
                "aaaaa": 5,
                "hoorayyy": 3,
                "x": 1,
                "aabcccddeeffffghijjk": 4,
                "aabcccddeeffzffghijjk": 3,
                }.items():
            self.assertEqual(ps(inpt),otpt)

unittest.main()
