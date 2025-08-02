### https://theweeklychallenge.org/blog/perl-weekly-challenge-318/
"""

Task 1: Group Position

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string of lowercase letters.

   Write a script to find the position of all groups in the given string.
   Three or more consecutive letters form a group. Return "” if none
   found.

Example 1

Input: $str = "abccccd"
Output: "cccc"

Example 2

Input: $str = "aaabcddddeefff"
Output: "aaa", "dddd", "fff"

Example 3

Input: $str = "abcdd"
Output: ""

Example 3

Input: @array = ("Morning", "Good")
       $word  = "MM"
Output: false

Task 2: Reverse Equals
"""
### solution by pokgopun@gmail.com

def gp(string: str) -> list[str]:
    lst: list[str] = []
    char = ""
    count = 0
    for c in string:
        if c == char:
            count += 1
        else:
            if count >= 3:
                lst.append(char * count)
            char = c
            count = 1
    else:
        if count >= 3:
            lst.append(char * count)
    if len(lst) == 0:
        return [""]
    return lst

import unittest

class TestGp(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "abccccd": ["cccc"],
                "aaabcddddeefff": ["aaa", "dddd", "fff"],
                "abcdd": [""],
                }.items():
            self.assertEqual(gp(inpt), otpt)

unittest.main()
