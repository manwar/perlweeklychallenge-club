### https://theweeklychallenge.org/blog/perl-weekly-challenge-317/
"""

Task 2: Friendly Strings

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two strings.

   Write a script to return true if swapping any two letters in one string
   match the other string, return false otherwise.

Example 1

Input: $str1 = "desc", $str2 = "dsec"
Output: true

Example 2

Input: $str1 = "fuck", $str2 = "fcuk"
Output: true

Example 3

Input: $str1 = "poo", $str2 = "eop"
Output: false

Example 4

Input: $str1 = "stripe", $str2 = "sprite"
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 20th April
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def fs(str1: str, str2: str) -> bool:
    l = len(str1)
    if l != len(str2):
        return False
    lst: list[str] = []
    for i in range(l):
        pr = (str1[i],str2[i])
        if  pr[0] != pr[1]:
            lst.extend(pr)
            if len(lst) > 4:
                return False
    return len(lst) == 4 and lst[0] == lst[3] and lst[1] == lst[2] 

import unittest

class TestFs(unittest.TestCase):
    def test(self):
        for (str1, str2), otpt in {
                ("desc", "dsec"): True,
                ("fuck", "fcuk"): True,
                ("poo", "eop"): False,
                ("stripe", "sprite"): True,
                ("stripe", "stripe"): False,
                ("stripe", "strip"): False,
                }.items():
            self.assertEqual(fs(str1,str2), otpt)

unittest.main()
