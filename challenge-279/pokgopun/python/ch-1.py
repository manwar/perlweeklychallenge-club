### https://theweeklychallenge.org/blog/perl-weekly-challenge-279/
"""

Task 1: Sort Letters

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two arrays, @letters and @weights.

   Write a script to sort the given array @letters based on the @weights.

Example 1

Input: @letters = ('R', 'E', 'P', 'L')
       @weights = (3, 2, 1, 4)
Output: PERL

Example 2

Input: @letters = ('A', 'U', 'R', 'K')
       @weights = (2, 4, 1, 3)
Output: RAKU

Example 3

Input: @letters = ('O', 'H', 'Y', 'N', 'P', 'T')
       @weights = (5, 4, 2, 6, 1, 3)
Output: PYTHON

Task 2: Split String
"""
### solution by pokgopun@gmail.com

def sortLetters(letters,weights):
    return "".join(
            e[1] for e in sorted(
                (weights[i],letters[i]) for i in range(len(letters))
                )
            )

import unittest

class TestSortLetters(unittest.TestCase):
    def test(self):
        for (letters,weights),otpt in {
                (('R', 'E', 'P', 'L'),(3, 2, 1, 4)): "PERL",
                (('A', 'U', 'R', 'K'),(2, 4, 1, 3)): "RAKU",
                (('O', 'H', 'Y', 'N', 'P', 'T'),(5, 4, 2, 6, 1, 3)): "PYTHON",
                }.items():
            self.assertEqual(sortLetters(letters,weights),otpt)

unittest.main()
