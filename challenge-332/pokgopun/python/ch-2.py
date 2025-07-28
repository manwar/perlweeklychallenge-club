### https://theweeklychallenge.org/blog/perl-weekly-challenge-332/
"""

Task 2: Odd Letters

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string.

   Write a script to find out if each letter in the given string appeared
   odd number of times.

Example 1

Input: $str = "weekly"
Output: false

w: 1 time
e: 2 times
k: 1 time
l: 1 time
y: 1 time

The letter 'e' appeared 2 times i.e. even.

Example 2

Input: $str = "perl"
Output: true

Example 3

Input: $source = "challenge"
Output: false
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 3rd August
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def ol(string: str) -> bool:
    cc: dict[str,int] = {}
    for c in string:
        cc[c] = cc.get(c,0) + 1
    for v in cc.values():
        if v % 2 == 0:
            return False
    return True

import unittest

class TestOl(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                "weekly": False,
                "perl": True,
                "challenge": False,
                }.items():
            self.assertEqual(ol(inpt),otpt)

unittest.main()
