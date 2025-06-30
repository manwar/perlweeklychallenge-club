### https://theweeklychallenge.org/blog/perl-weekly-challenge-328/
"""

Task 1: Replace all ?

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing only lower case English letters and
   ?.

   Write a script to replace all ? in the given string so that the string
   doesn’t contain consecutive repeating characters.

Example 1

Input: $str = "a?z"
Output: "abz"

There can be many strings, one of them is "abz".
The choices are 'a' to 'z' but we can't use either 'a' or 'z' to replace the '?'
.

Example 2

Input: $str = "pe?k"
Output: "peak"

Example 3

Input: $str = "gra?te"
Output: "grabte"

Task 2: Good String
"""
### solution by pokgopun@gmail.com

def ra(string: str) -> str:
    chrs = list(string)
    l = len(chrs)
    first = ord('a')
    last = ord('z')
    for i in range(l):
        if chrs[i] == '?':
            lst: list[str] = []
            if i > 0:
                prv = chrs[i-1]
                if prv.isalpha():
                    lst.append(ord(prv))
            if i < l - 1:
                nxt = chrs[i+1]
                if nxt.isalpha():
                    lst.append(ord(nxt))
            for j in range(first,last+1):
                if j not in lst:
                    chrs[i] = chr(j)
                    break
    return "".join(chrs)

import unittest

class TestRa(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "a?z": "abz",
                "pe?k": "peak",
                "gra?te": "grabte",
                }.items():
            self.assertEqual(ra(inpt),otpt)

unittest.main()
