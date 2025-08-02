### https://theweeklychallenge.org/blog/perl-weekly-challenge-309/
"""

Task 1: Min Gap

Submitted by: [40]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints, increasing order.

   Write a script to return the element before which you find the smallest
   gap.

Example 1

Input: @ints = (2, 8, 10, 11, 15)
Output: 11

 8 - 2  => 6
10 - 8  => 2
11 - 10 => 1
15 - 11 => 4

11 is where we found the min gap.

Example 2

Input: @ints = (1, 5, 6, 7, 14)
Output: 6

 5 - 1 => 4
 6 - 5 => 1
 7 - 6 => 1
14 - 7 => 7

6 and 7 where we found the min gap, so we pick the first instance.

Example 3

Input: @ints = (8, 20, 25, 28)
Output: 28

 8 - 20 => 14
25 - 20 => 5
28 - 25 => 3

28 is where we found the min gap.

Task 2: Min Diff
"""
### solution by pokgopun@gmail.com

def minGap(ints: tuple[int]) -> int:
    l = len(ints)
    if l < 2:
        return None
    mn = (ints[1]-ints[0], ints[1])
    for i in range(1,l-1):
        a, b = ints[i], ints[i+1]
        mn0 = b - a
        if mn0 < mn[0]: 
            mn = (mn0, b)
    return mn[1]

import unittest

class TestMinGap(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (2, 8, 10, 11, 15): 11,
                (1, 5, 6, 7, 14): 6,
                (8, 20, 25, 28): 28,
                }.items():
            self.assertEqual(minGap(inpt),otpt)

unittest.main()
