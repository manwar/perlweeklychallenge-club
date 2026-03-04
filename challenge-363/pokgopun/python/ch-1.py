### https://theweeklychallenge.org/blog/perl-weekly-challenge-363/
"""

Task 1: String Lie Detector

Submitted by: [52]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string.

   Write a script that parses a self-referential string and determines
   whether its claims about itself are true. The string will make
   statements about its own composition, specifically the number of vowels
   and consonants it contains.

Example 1

Input: $str = "aa — two vowels and zero consonants"
Output: true

Example 2

Input: $str = "iv — one vowel and one consonant"
Output: true

Example 3

Input: $str = "hello - three vowels and two consonants"
Output: false

Example 4

Input: $str = "aeiou — five vowels and zero consonants"
Output: true

Example 5

Input: $str = "aei — three vowels and zero consonants"
Output: true

Task 2: Subnet Sheriff
"""
### solution by pokgopun@gmail.com

from word2num import word2num as w2n

def sld(string: str) -> bool:
    chars, _, vwl_cnt, _, _, csn_cnt, _ = string.lower().split(" ")
    vwl_cnt = w2n(vwl_cnt)
    csn_cnt = w2n(csn_cnt)
    for ch in chars:
        if ch in "aeiou":
            vwl_cnt -= 1
        else:
            csn_cnt -= 1
    return vwl_cnt == 0 and csn_cnt == 0

import unittest

class TestSld(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "aa — two vowels and zero consonants" :True,
                "iv — one vowel and one consonant" :True,
                "hello - three vowels and two consonants": False,
                "aeiou — five vowels and zero consonants" :True,
                "aei — three vowels and zero consonants": True,
                }.items():
            self.assertEqual(sld(inpt), otpt)

unittest.main()
