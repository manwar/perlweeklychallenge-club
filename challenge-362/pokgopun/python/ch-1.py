### https://theweeklychallenge.org/blog/perl-weekly-challenge-362/
"""

Task 1: Echo Chamber

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing lowercase letters.

   Write a script to transform the string based on the index position of
   each character (starting from 0). For each character at position i,
   repeat it i + 1 times.

Example 1

Input: "abca"
Output: "abbcccaaaa"

Index 0: "a" -> repeated 1 time  -> "a"
Index 1: "b" -> repeated 2 times -> "bb"
Index 2: "c" -> repeated 3 times -> "ccc"
Index 3: "a" -> repeated 4 times -> "aaaa"

Example 2

Input: "xyz"
Output: "xyyzzz"

Index 0: "x" -> "x"
Index 1: "y" -> "yy"
Index 2: "z" -> "zzz"

Example 3

Input: "code"
Output: "coodddeeee"

Index 0: "c" -> "c"
Index 1: "o" -> "oo"
Index 2: "d" -> "ddd"
Index 3: "e" -> "eeee"

Example 4

Input: "hello"
Output: "heelllllllooooo"

Index 0: "h" -> "h"
Index 1: "e" -> "ee"
Index 2: "l" -> "lll"
Index 3: "l" -> "llll"
Index 4: "o" -> "ooooo"

Example 5

Input: "a"
Output: "a"

Index 0: "a" -> "a"

Task 2: Spellbound Sorting
"""
### solution by pokgopun@gmail.com

def echoChamber(string: str) -> str:
    return "".join(string[i]*(i+1) for i in range(len(string)))

import unittest

class TestEchoChamber(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "abca" : "abbcccaaaa" ,
                "xyz" : "xyyzzz" ,
                "code" : "coodddeeee" ,
                "hello" : "heelllllllooooo" ,
                "a" : "a",
                }.items():
            self.assertEqual(echoChamber(inpt), otpt)

unittest.main()
