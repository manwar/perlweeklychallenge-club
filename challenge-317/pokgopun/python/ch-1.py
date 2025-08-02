### https://theweeklychallenge.org/blog/perl-weekly-challenge-317/
"""

Task 1: Acronyms

Submitted by: [44]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of words and a word.

   Write a script to return true if concatenating the first letter of each
   word in the given array matches the given word, return false otherwise.

Example 1

Input: @array = ("Perl", "Weekly", "Challenge")
       $word  = "PWC"
Output: true

Example 2

Input: @array = ("Bob", "Charlie", "Joe")
       $word  = "BCJ"
Output: true

Example 3

Input: @array = ("Morning", "Good")
       $word  = "MM"
Output: false

Task 2: Friendly Strings
"""
### solution by pokgopun@gmail.com

def acro(words: tuple[str], word: str) -> bool:
    l = len(words)
    if l != len(word):
        return False
    for i in range(l):
        if words[i][0] != word[i]:
            return False
    return True

import unittest

class TestAcro(unittest.TestCase):
    def test(self):
        for (words, word), otpt in {
                (("Perl", "Weekly", "Challenge"), "PWC"): True,
                (("Bob", "Charlie", "Joe"), "BCJ"): True,
                (("Morning", "Good"), "MM"): False,
                }.items():
            self.assertEqual(acro(words,word), otpt)

unittest.main()
