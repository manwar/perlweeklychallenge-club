### https://theweeklychallenge.org/blog/perl-weekly-challenge-330/
"""

Task 2: Title Capital

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string made up of one or more words separated by a
   single space.

   Write a script to capitalise the given title. If the word length is 1
   or 2 then convert the word to lowercase otherwise make the first
   character uppercase and remaining lowercase.

Example 1

Input: $str = "PERL IS gREAT"
Output: "Perl is Great"

Example 2

Input: $str = "THE weekly challenge"
Output: "The Weekly Challenge"

Example 3

Input: $str = "YoU ARE A stAR"
Output: "You Are a Star"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 20th July 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def tc(string: str) -> str:
    return " ".join( e.title() if len(e) > 2 else e for e in string.lower().split() )

import unittest

class TestTc(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "PERL IS gREAT": "Perl is Great",
                "THE weekly challenge": "The Weekly Challenge",
                "YoU ARE A stAR": "You Are a Star",
                }.items():
            self.assertEqual(tc(inpt),otpt)

unittest.main()
 
