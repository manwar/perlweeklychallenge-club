### https://theweeklychallenge.org/blog/perl-weekly-challenge-260/
"""

Task 2: Dictionary Rank

Submitted by: [43]Mark Anderson
     __________________________________________________________________

   You are given a word, $word.

   Write a script to compute the dictionary rank of the given word.

Example 1

Input: $word = 'CAT'
Output: 3

All possible combinations of the letters:
CAT, CTA, ATC, TCA, ACT, TAC

Arrange them in alphabetical order:
ACT, ATC, CAT, CTA, TAC, TCA

CAT is the 3rd in the list.
Therefore the dictionary rank of CAT is 3.

Example 2

Input: $word = 'GOOGLE'
Output: 88

Example 3

Input: $word = 'SECRET'
Output: 255
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 17th March
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from itertools import permutations

def DC(word: str):
    return tuple(
            sorted(
                set(
                    permutations(word,len(word))
                    )
                )
            ).index(tuple(word)) + 1

import unittest

class TestDC(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                'CAT': 3,
                'GOOGLE': 88,
                'SECRET': 255,
                }.items():
            self.assertEqual(DC(inpt),otpt)

unittest.main()
