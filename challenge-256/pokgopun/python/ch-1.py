### https://theweeklychallenge.org/blog/perl-weekly-challenge-256/
"""

Task 1: Maximum Pairs

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of distinct words, @words.

   Write a script to find the maximum pairs in the given array. The words
   $words[i] and $words[j] can be a pair one is reverse of the other.

Example 1

Input: @words = ("ab", "de", "ed", "bc")
Output: 1

There is one pair in the given array: "de" and "ed"

Example 2

Input: @words = ("aa", "ba", "cd", "ed")
Output: 0

Example 3

Input: @words = ("uv", "qp", "st", "vu", "mn", "pq"))
Output: 2

Task 2: Merge Strings
"""
### solution by pokgopun@gmail.com

def maxPair(words: tuple):
    c = 0
    for i in range(len(words)-1):
        for e in words[i+1:]:
            if tuple(words[i])==tuple(reversed(e)):
                c += 1
    return c

import unittest

class TestMaxPair(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                ("ab", "de", "ed", "bc"): 1,
                ("aa", "ba", "cd", "ed"): 0,
                ("uv", "qp", "st", "vu", "mn", "pq"): 2,
                }.items():
            self.assertEqual(maxPair(inpt),otpt)

unittest.main()
