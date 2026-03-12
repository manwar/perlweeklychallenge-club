### https://theweeklychallenge.org/blog/perl-weekly-challenge-364/
"""

Task 1: Decrypt String

Submitted by: [65]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string formed by digits and ‘#'.

   Write a script to map the given string to English lowercase characters
   following the given rules.
- Characters 'a' to 'i' are represented by '1' to '9' respectively.
- Characters 'j' to 'z' are represented by '10#' to '26#' respectively.

Example 1

Input: $str = "10#11#12"
Output: "jkab"

10# -> j
11# -> k
1   -> a
2   -> b

Example 2

Input: $str = "1326#"
Output: "acz"

1   -> a
3   -> c
26# -> z

Example 3

Input: $str = "25#24#123"
Output: "yxabc"

25# -> y
24# -> x
1   -> a
2   -> b
3   -> c

Example 4

Input: $str = "20#5"
Output: "te"

20# -> t
5   -> e

Example 5

Input: $str = "1910#26#"
Output: "aijz"

1   -> a
9   -> i
10# -> j
26# -> z

Task 2: Goal Parser
"""
### solution by pokgopun@gmail.com

import re

pattern = re.compile("|".join(str(e) if e < 10 else f"{str(e)}#" for e in range(26,0,-1)))

def decryptString(string: str) -> str:
    out = ""
    i = 0
    while True:
        m = pattern.search(string,i)
        if m == None:
            break
        out += chr(96 + int(m.group(0).rstrip("#")))
        i = m.span()[1]
    return out

import unittest

class TestDecryptString(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "10#11#12" : "jkab" ,
                "1326#" : "acz" ,
                "25#24#123" : "yxabc" ,
                "20#5" : "te" ,
                "1910#26#" : "aijz",
                }.items():
            self.assertEqual(decryptString(inpt), otpt)

unittest.main()
