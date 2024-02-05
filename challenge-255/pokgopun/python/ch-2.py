### https://theweeklychallenge.org/blog/perl-weekly-challenge-255/
"""

Task 2: Most Frequent Word

Submitted by: [47]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a paragraph $p and a banned word $w.

   Write a script to return the most frequent word that is not banned.

Example 1

Input: $p = "Joe hit a ball, the hit ball flew far after it was hit."
       $w = "hit"
Output: "ball"

The banned word "hit" occurs 3 times.
The other word "ball" occurs 2 times.

Example 2

Input: $p = "Perl and Raku belong to the same family. Perl is the most popular l
anguage in the weekly challenge."
       $w = "the"
Output: "Perl"

The banned word "the" occurs 3 times.
The other word "Perl" occurs 2 times.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 11th February
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

import re

def mostFreqWord(p,w: str):
    dct = dict()
    for s in ( e.group(0) for e in re.finditer(r'\w+',p) if e.group(0) != w ):
        dct[s] = dct.setdefault(s,0) + 1
    mx = max(dct.values())
    for e in dct.items():
        if e[1] == mx: return e[0]

import unittest

class TestMostFreqWord(unittest.TestCase):
    def test(self):
        for (p,w), otpt in {
                ("Joe hit a ball, the hit ball flew far after it was hit.","hit"): "ball",
                ("Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.","the"): "Perl",
                }.items():
            self.assertEqual(mostFreqWord(p,w),otpt)

unittest.main()
