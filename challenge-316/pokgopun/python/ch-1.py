### https://theweeklychallenge.org/blog/perl-weekly-challenge-316/
"""

Task 1: Circular

Submitted by: [39]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of words.

   Write a script to find out whether the last character of each word is
   the first character of the following word.

Example 1

Input: @list = ("perl", "loves", "scala")
Output: true

Example 2

Input: @list = ("love", "the", "programming")
Output: false

Example 3

Input: @list = ("java", "awk", "kotlin", "node.js")
Output: true

Task 2: Subsequence
"""
### solution by pokgopun@gmail.com

def ccr(words: tuple[str]) -> str:
    l = len(words)
    if l < 2:
        return False
    for i in range(l-1):
        if words[i][-1] != words[i+1][0]:
            return False
    return True

import unittest
class testCcr(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                ("perl", "loves", "scala"): True,
                ("love", "the", "programming"): False,
                ("java", "awk", "kotlin", "node.js"): True,
                }.items():
            self.assertEqual(ccr(inpt), otpt)

unittest.main()
