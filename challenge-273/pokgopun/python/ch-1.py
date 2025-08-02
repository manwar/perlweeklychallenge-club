### https://theweeklychallenge.org/blog/perl-weekly-challenge-273/
"""

Task 1: Percentage of Character

Submitted by: [52]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string, $str and a character $char.

   Write a script to return the percentage, nearest whole, of given
   character in the given string.

Example 1

Input: $str = "perl", $char = "e"
Output: 25

Example 2

Input: $str = "java", $char = "a"
Output: 50

Example 3

Input: $str = "python", $char = "m"
Output: 0

Example 4

Input: $str = "ada", $char = "a"
Output: 67

Example 5

Input: $str = "ballerina", $char = "l"
Output: 22

Example 6

Input: $str = "analitik", $char = "k"
Output: 13

Task 2: B After A
"""
### solution by pokgopun@gmail.com

def poc(string, char):
    res = 1000 * string.count(char) / len(string)
    return res // 10 if res % 10 < 5 else 1 + res // 10

import unittest

class TestPoc(unittest.TestCase):
    def test(self):
        for (string, char), otpt in {
                ("perl", "e"): 25,
                ("java", "a"): 50,
                ("python", "m"): 0,
                ("ada", "a"): 67,
                ("ballerina", "l"): 22,
                ("analitik", "k"): 13,
                }.items():
            self.assertEqual(poc(string, char), otpt)

unittest.main()
