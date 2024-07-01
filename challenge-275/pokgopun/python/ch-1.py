### https://theweeklychallenge.org/blog/perl-weekly-challenge-275/
"""

Task 1: Broken Keys

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a sentence, $sentence and list of broken keys @keys.

   Write a script to find out how many words can be typed fully.

Example 1

Input: $sentence = "Perl Weekly Challenge", @keys = ('l', 'a')
Output: 0

Example 2

Input: $sentence = "Perl and Raku", @keys = ('a')
Output: 1

Only Perl since the other word two words contain 'a' and can't be typed fully.

Example 3

Input: $sentence = "Well done Team PWC", @keys = ('l', 'o')
Output: 2

Example 4

Input: $sentence = "The joys of polyglottism", @keys = ('T')
Output: 2

Task 2: Replace Digits
"""
### solution by pokgopun@gmail.com

def bk(sentence: str, keys: tuple):
    keys = set(e.lower() for e in keys)
    return sum(
            1 for e in sentence.split() if set(e.lower()).intersection(keys) == set()
            )

import unittest

class TestBk(unittest.TestCase):
    def test(self):
        for (sentence, keys), otpt in {
                ("Perl Weekly Challenge", ('l', 'a')): 0,
                ("Perl and Raku", ('a',)): 1,
                ("Well done Team PWC", ('l', 'o')): 2,
                ("The joys of polyglottism", ('T',)): 2,
                }.items():
            self.assertEqual(bk(sentence,keys),otpt)

unittest.main()


