### https://theweeklychallenge.org/blog/perl-weekly-challenge-299/
"""

Task 1: Replace Words

Submitted by: [49]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of words and a sentence.

   Write a script to replace all words in the given sentence that start
   with any of the words in the given array.

Example 1

Input: @words = ("cat", "bat", "rat")
       $sentence = "the cattle was rattle by the battery"
Output: "the cat was rat by the bat"

Example 2

Input: @words = ("a", "b", "c")
       $sentence = "aab aac and cac bab"
Output: "a a a c b"

Example 3

Input: @words = ("man", "bike")
       $sentence = "the manager was hit by a biker"
Output: "the man was hit by a bike"

Task 2: Word Search
"""
### solution by pokgopun@gmail.com

from typing import Tuple

def rw(words: Tuple[str], sentence: str) -> str:
    sntnce = sentence.split()
    for word in words:
        for i in range(len(sntnce)):
            if sntnce[i].startswith(word):
                sntnce[i] = word
    return " ".join(sntnce)

import unittest

class TestRw(unittest.TestCase):
    def test(self):
        for (words, sentence), otpt in {
                (("cat", "bat", "rat"),"the cattle was rattle by the battery"): "the cat was rat by the bat",
                (("a", "b", "c"),"aab aac and cac bab"): "a a a c b",
                (("man", "bike"), "the manager was hit by a biker"): "the man was hit by a bike",
                }.items():
            self.assertEqual(rw(words,sentence),otpt)

unittest.main()
