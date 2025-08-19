### https://theweeklychallenge.org/blog/perl-weekly-challenge-335/
"""

Task 1: Common Characters

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of words.

   Write a script to return all characters that is in every word in the
   given array including duplicates.

Example 1

Input: @words = ("bella", "label", "roller")
Output: ("e", "l", "l")

Example 2

Input: @words = ("cool", "lock", "cook")
Output: ("c", "o")

Example 3

Input: @words = ("hello", "world", "pole")
Output: ("l", "o")

Example 4

Input: @words = ("abc", "def", "ghi")
Output: ()

Example 5

Input: @words = ("aab", "aac", "aaa")
Output: ("a", "a")

Task 2: Find Winner
"""
### solution by pokgopun@gmail.com

def cc(words: tuple[str]) -> tuple[str]:
    res = list(words[0])
    rmn = [list(e) for e in words[1:]]
    for c in words[0]:
        for word in rmn:
            try:
                word.remove(c)
            except:
                res.remove(c)
                break
    return tuple(res)

import unittest

class TestCc(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                ("bella", "label", "roller"): ("e", "l", "l"),
                ("cool", "lock", "cook"): ("c", "o"),
                ("hello", "world", "pole"): ("l", "o"),
                ("abc", "def", "ghi"): (),
                ("aab", "aac", "aaa"): ("a", "a"),
                }.items():
            self.assertEqual(cc(inpt),otpt)

unittest.main()
