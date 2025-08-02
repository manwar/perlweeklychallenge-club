### https://theweeklychallenge.org/blog/perl-weekly-challenge-305/
"""

Task 2: Alien Dictionary

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of words and alien dictionary character order.

   Write a script to sort lexicographically the given list of words based
   on the alien dictionary characters.

Example 1

Input: @words = ("perl", "python", "raku")
       @alien = qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/
Output: ("raku", "python", "perl")

Example 2

Input: @words = ("the", "weekly", "challenge")
       @alien = qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/
Output: ("challenge", "the", "weekly")
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 26^th January
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from typing import Tuple

def ad(words: Tuple[str], alien: str) -> Tuple[str]:
    al = alien.split()
    return tuple(
            sorted(
                words, key=lambda w: "".join(al[ord(c)-97] for c in w)
                )
            )

import unittest

class TestAd(unittest.TestCase):
    def test(self):
        for (words, alien), otpt in {
                (("perl", "python", "raku"),"h l a b y d e f g i r k m n o p q j s t u v w x c z"): ("raku", "python", "perl"),
                (("the", "weekly", "challenge"),"c o r l d a b t e f g h i j k m n p q s w u v x y z"): ("challenge", "the", "weekly"),
                }.items():
            self.assertEqual(ad(words,alien), otpt)

unittest.main()
