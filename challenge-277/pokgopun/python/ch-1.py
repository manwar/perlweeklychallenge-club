### https://theweeklychallenge.org/blog/perl-weekly-challenge-277/
"""

Task 1: Count Common

Submitted by: [53]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two array of strings, @words1 and @words2.

   Write a script to return the count of words that appears in both arrays
   exactly once.

Example 1

Input: @words1 = ("Perl", "is", "my", "friend")
       @words2 = ("Perl", "and", "Raku", "are", "friend")
Output: 2

The words "Perl" and "friend" appear once in each array.

Example 2

Input: @words1 = ("Perl", "and", "Python", "are", "very", "similar")
       @words2 = ("Python", "is", "top", "in", "guest", "languages")
Output: 1

Example 3

Input: @words1 = ("Perl", "is", "imperative", "Lisp", "is", "functional")
       @words2 = ("Crystal", "is", "similar", "to", "Ruby")
Output: 0

Task 2: Strong Pair
"""
### solution by pokgopun@gmail.com

def  countCommon(words1, words2):
    return len(
            set(
                e for e in set(words1) if words1.count(e)==1
                ).intersection(
                    set(
                        e for e in set(words2) if words2.count(e)==1
                        )
                    )
                )

import unittest

class TestCountCommon(unittest.TestCase):
    def test(self):
        for (words1, words2), cc in {
                (("Perl", "is", "my", "friend"),("Perl", "and", "Raku", "are", "friend")): 2,
                (("Perl", "and", "Python", "are", "very", "similar"),("Python", "is", "top", "in", "guest", "languages")): 1,
                (("Perl", "is", "imperative", "Lisp", "is", "functional"),("Crystal", "is", "similar", "to", "Ruby")): 0,
                }.items():
            self.assertEqual(countCommon(words1,words2),cc)

unittest.main()


