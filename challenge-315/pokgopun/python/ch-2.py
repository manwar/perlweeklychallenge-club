### https://theweeklychallenge.org/blog/perl-weekly-challenge-315/
"""

Task 2: Find Third

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a sentence and two words.

   Write a script to return all words in the given sentence that appear in
   sequence to the given two words.

Example 1

Input: $sentence = "Perl is a my favourite language but Python is my favourite t
oo."
       $first = "my"
       $second = "favourite"
Output: ("language", "too")

Example 2

Input: $sentence = "Barbie is a beautiful doll also also a beautiful princess."
       $first = "a"
       $second = "beautiful"
Output: ("doll", "princess")

Example 3

Input: $sentence = "we will we will rock you rock you.",
       $first = "we"
       $second = "will"
Output: ("we", "rock")
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 6th April 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def f3rd(sentence: str, first: str, second: str) -> tuple[str]:
    tup: tuple(str) = tuple()
    frst = ""
    scnd = ""
    for s in (e.strip(".,")for e in sentence.split(" ")):
        if scnd != "":
            if frst == first and scnd == second:
                tup += (s,)
            frst = scnd
            scnd = s
        elif frst == "":
            frst = s
        else:
            scnd = s
    return tup

import unittest

class TestF3rd(unittest.TestCase):
    def test(self):
        for (sentence, first, second), otpt in {
                ("Perl is a my favourite language but Python is my favourite too.","my","favourite"): ("language", "too"),
                ("Barbie is a beautiful doll also also a beautiful princess.","a","beautiful"): ("doll", "princess"),
                ("we will we will rock you rock you.", "we", "will"): ("we", "rock"),
                }.items():
            self.assertEqual(f3rd(sentence,first,second), otpt)

unittest.main()
