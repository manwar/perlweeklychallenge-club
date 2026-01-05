### https://theweeklychallenge.org/blog/perl-weekly-challenge-355/
"""

Task 1: Thousand Separator

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a positive integer, $int.

   Write a script to add thousand separator, , and return as string.

Example 1

Input: $int = 123
Output: "123"

Example 2

Input: $int = 1234
Output: "1,234"

Example 3

Input: $int = 1000000
Output: "1,000,000"

Example 4

Input: $int = 1
Output: "1"

Example 5

Input: $int = 12345
Output: "12,345"

Task 2: Mountain Array
"""
### solution by pokgopun@gmail.com

def ts(num: int) -> str:
    if num  >= 1000:
        return ts(num//1000) + ",{:03d}".format(num%1000)
    return str(num)

import unittest

class TestTs(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                123: "123",
                1234: "1,234",
                1000000: "1,000,000",
                1: "1",
                12345: "12,345",
                }.items():
            self.assertEqual(ts(inpt),otpt)

unittest.main()
