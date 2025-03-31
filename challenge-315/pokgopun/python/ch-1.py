### https://theweeklychallenge.org/blog/perl-weekly-challenge-315/
"""

Task 1: Find Words

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of words and a character.

   Write a script to return the index of word in the list where you find
   the given character.

Example 1

Input: @list = ("the", "weekly", "challenge")
       $char = "e"
Output: (0, 1, 2)

Example 2

Input: @list = ("perl", "raku", "python")
       $char = "p"
Output: (0, 2)

Example 3

Input: @list = ("abc", "def", "bbb", "bcd")
       $char = "b"
Output: (0, 2, 3)

Task 2: Find Third
"""
### solution by pokgopun@gmail.com

def fw(words: tuple[str], char: str) -> tuple[int]:
    return tuple(i for i in range(len(words))if char in words[i])

import unittest

class TestFw(unittest.TestCase):
    def test(self):
        for (words, char), otpt in {
                (("the", "weekly", "challenge"), "e"): (0, 1, 2),
                (("perl", "raku", "python"), "p"): (0, 2),
                (("abc", "def", "bbb", "bcd"), "b"): (0, 2, 3),
                }.items():
            self.assertEqual(fw(words,char), otpt)

unittest.main()
