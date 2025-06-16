### https://theweeklychallenge.org/blog/perl-weekly-challenge-326/
"""

Task 1: Day of the Year

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a date in the format YYYY-MM-DD.

   Write a script to find day number of the year that the given date
   represent.

Example 1

Input: $date = '2025-02-02'
Output: 33

The 2nd Feb, 2025 is the 33rd day of the year.

Example 2

Input: $date = '2025-04-10'
Output: 100

Example 3

Input: $date = '2025-09-07'
Output: 250

Task 2: Decompressed List
"""
### solution by pokgopun@gmail.com

def doy(date: str) -> int:
    y, m, d = (int(e) for e in date.split('-'))
    return d + 30*(m-1) + sum((e-7*(e//8))%2 for e in range(1,m)) - (m>2)*(2 - ilp(y))  

def ilp(y: int) -> bool:
    if y % 4 == 0:
        if y % 100 == 0:
            return y % 400 == 0
        else:
            return True
    return False

import unittest

class TestDoy(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                '2025-02-02': 33,
                '2025-04-10': 100,
                '2025-09-07': 250,
                }.items():
            self.assertEqual(doy(inpt),otpt)

unittest.main()
