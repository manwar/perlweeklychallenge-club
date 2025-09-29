### https://theweeklychallenge.org/blog/perl-weekly-challenge-341/
"""

Task 2: Reverse Prefix

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str and a character in the given string,
   $char.

   Write a script to reverse the prefix upto the first occurrence of the
   given $char in the given string $str and return the new string.

Example 1

Input: $str = "programming", $char = "g"
Output: "gorpramming"

Reverse of prefix "prog" is "gorp".

Example 2

Input: $str = "hello", $char = "h"
Output: "hello"

Example 3

Input: $str = "abcdefghij", $char = "h"
Output: "hgfedcbaij"

Example 4

Input: $str = "reverse", $char = "s"
Output: "srevere"

Example 5

Input: $str = "perl", $char = "r"
Output: "repl"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 5th October
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def rp(string: str, char: str) -> str:
    i = string.find(char)
    if i < 1:
        return string
    return "".join(reversed(string[:i+1])) + string[i+1:]

import unittest

class TestRp(unittest.TestCase):
    def test(self):
        for (string,char), otpt in {
                ("programming", "g"): "gorpramming",
                ("hello", "h"): "hello",
                ("abcdefghij", "h"): "hgfedcbaij",
                ("reverse", "s"): "srevere",
                ("perl", "r"): "repl",
                }.items():
            self.assertEqual(rp(string,char),otpt)

unittest.main()
