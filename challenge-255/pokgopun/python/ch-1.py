### https://theweeklychallenge.org/blog/perl-weekly-challenge-255/
"""

Task 1: Odd Character

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two strings, $s and $t. The string $t is generated using
   the shuffled characters of the string $s with an additional character.

   Write a script to find the additional character in the string $t..

Example 1

Input: $s = "Perl" $t = "Preel"
Output: "e"

Example 2

Input: $s = "Weekly" $t = "Weeakly"
Output: "a"

Example 3

Input: $s = "Box" $t = "Boxy"
Output: "y"

Task 2: Most Frequent Word
"""
### solution by pokgopun@gmail.com

def oddChar(s,t: str):
    for c in s:
        t = t.replace(c,"",1)
    return t

import unittest

class TestOddChar(unittest.TestCase):
    def test(self):
        for (s,t), otpt in {
                ("Perl","Preel"): "e",
                ("Weekly","Weeakly"): "a",
                ("Box","Boxy"): "y",
                }.items():
            self.assertEqual(oddChar(s,t), otpt)

unittest.main()
