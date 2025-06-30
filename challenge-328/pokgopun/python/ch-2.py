### https://theweeklychallenge.org/blog/perl-weekly-challenge-328/
"""

Task 2: Good String

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string made up of lower and upper case English letters
   only.

   Write a script to return the good string of the given string. A string
   is called good string if it doesn’t have two adjacent same characters,
   one in upper case and other is lower case.

Example 1

Input: $str = "WeEeekly"
Output: "Weekly"

We can remove either, "eE" or "Ee" to make it good.

Example 2

Input: $str = "abBAdD"
Output: ""

We remove "bB" first: "aAdD"
Then we remove "aA": "dD"
Finally remove "dD".

Example 3

Input: $str = "abc"
Output: "abc"
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 6th July 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def gs(string: str) -> str:
    chrs = list(string)
    while True:
        for i in range(1,len(chrs)):
            if abs(ord(chrs[i])-ord(chrs[i-1])) == 32:
                chrs = chrs[:i-1] + chrs[i+1:]
                break
        else:
            break
    return "".join(chrs)

import unittest

class TestGs(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "WeEeekly": "Weekly",
                "abBAdD": "",
                "abc": "abc",
                }.items():
            self.assertEqual(gs(inpt),otpt)

unittest.main()
