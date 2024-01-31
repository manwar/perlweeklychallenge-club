### https://theweeklychallenge.org/blog/perl-weekly-challenge-254/
"""

Task 2: Reverse Vowels

Submitted by: [48]Mohammad S Anwar
     __________________________________________________________________

   You are given a string, $s.

   Write a script to reverse all the vowels (a, e, i, o, u) in the given
   string.

Example 1

Input: $s = "Raku"
Output: "Ruka"

Example 2

Input: $s = "Perl"
Output: "Perl"

Example 3

Input: $s = "Julia"
Output: "Jaliu"

Example 4

Input: $s = "Uiua"
Output: "Auiu"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 4th February
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def reverseVowels(word: str):
    rword = ""
    vwl = "aeiou"
    vwls = tuple(c for c in word.lower() if c in vwl)
    i = -1
    for c in word:
        if c.lower() in vwl:
            rword += vwls[i]
            i -= 1
        else:
            rword += c
    return rword.title()

import unittest

class TestReverseVowels(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                "Raku": "Ruka",
                "Perl": "Perl",
                "Julia": "Jaliu",
                "Uiua": "Auiu",
                }.items():
            self.assertEqual(reverseVowels(inpt),otpt)

unittest.main()
