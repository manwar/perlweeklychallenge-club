### https://theweeklychallenge.org/blog/perl-weekly-challenge-321/
"""

Task 2: Backspace Compare

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given two strings containing zero or more #.

   Write a script to return true if the two given strings are same by
   treating # as backspace.

Example 1

Input: $str1 = "ab#c"
       $str2 = "ad#c"
Output: true

For first string,  we remove "b" as it is followed by "#".
For second string, we remove "d" as it is followed by "#".
In the end both strings became the same.

Example 2

Input: $str1 = "ab##"
       $str2 = "a#b#"
Output: true

Example 3

Input: $str1 = "a#b"
       $str2 = "c"
Output: false
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 18th May 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def bc(str1: str, str2: str) -> bool:
    return ab(str1) == ab(str2)

def ab(string: str) -> str:
    lst = list(string)
    l = len(lst)
    i = 0
    while i < l:
        if lst[i] == "#":
            lst.pop(i)
            l -= 1
            if i > 0:
                lst.pop(i-1)
                l -= 1
                i -= 1
        else:
            i += 1
    return "".join(lst)

import unittest

class TestBc(unittest.TestCase):
    def test(self):
        for (str1, str2), otpt in {
                ("ab#c", "ad#c"): True,
                ("ab##", "a#b#"): True,
                ("a#b", "c"): False,
                }.items():
            self.assertEqual(bc(str1,str2),otpt)

unittest.main()
