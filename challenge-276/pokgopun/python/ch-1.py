### https://theweeklychallenge.org/blog/perl-weekly-challenge-276/
"""

Task 1: Complete Day

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @hours.

   Write a script to return the number of pairs that forms a complete day.

     A complete day is defined as a time duration that is an exact
     multiple of 24 hours.

Example 1

Input: @hours = (12, 12, 30, 24, 24)
Output: 2

Pair 1: (12, 12)
Pair 2: (24, 24)

Example 2

Input: @hours = (72, 48, 24, 5)
Output: 3

Pair 1: (72, 48)
Pair 2: (72, 24)
Pair 3: (48, 24)

Example 3

Input: @hours = (12, 18, 24)
Output: 0

Task 2: Maximum Frequency
"""
### solution by pokgopun@gmail.com

def completeDay(hours: tuple):
    c = 0
    l = len(hours)
    for i in range(l-1):
        for j in range(i+1, l):
            if (hours[i] + hours[j]) % 24 == 0:
                c += 1
    return c

import unittest

class TestCompleteDay(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (12, 12, 30, 24, 24): 2,
                (72, 48, 24, 5): 3,
                (12, 18, 24): 0,
                }.items():
            self.assertEqual(completeDay(inpt),otpt)

unittest.main()
