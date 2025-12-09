### https://theweeklychallenge.org/blog/perl-weekly-challenge-351/
"""

Task 1: Special Average

Submitted by: [55]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers.

   Write a script to return the average excluding the minimum and maximum
   of the given array.

Example 1

Input: @ints = (8000, 5000, 6000, 2000, 3000, 7000)
Output: 5250

Min: 2000
Max: 8000
Avg: (3000+5000+6000+7000)/4 = 21000/4 = 5250

Example 2

Input: @ints = (100_000, 80_000, 110_000, 90_000)
Output: 95_000

Min: 80_000
Max: 110_000
Avg: (100_000 + 90_000)/2 = 190_000/2 = 95_000

Example 3

Input: @ints = (2500, 2500, 2500, 2500)
Output: 0

Min: 2500
Max: 2500
Avg: 0

Example 4

Input: @ints = (2000)
Output: 0

Min: 2000
Max: 2000
Avg: 0

Example 5

Input: @ints = (1000, 2000, 3000, 4000, 5000, 6000)
Output: 3500

Min: 1000
Max: 6000
Avg: (2000 + 3000 + 4000 + 5000)/4 = 14000/4 = 3500

Task 2: Arithmetic Progression
"""
### solution by pokgopun@gmail.com

def sa(ints: tuple[int]) -> int:
    mn = min(ints)
    mx = max(ints)
    sm, n = 0, 0
    for v in ints:
        if v not in (mn,mx):
            sm += v
            n += 1
    return sm > 0 and sm/n or 0

import unittest

class TestSa(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (8000, 5000, 6000, 2000, 3000, 7000): 5250,
                (100_000, 80_000, 110_000, 90_000): 95_000,
                (2500, 2500, 2500, 2500): 0,
                (2000,): 0,
                (1000, 2000, 3000, 4000, 5000, 6000): 3500,
                }.items():
            self.assertEqual(sa(inpt), otpt)

unittest.main()
