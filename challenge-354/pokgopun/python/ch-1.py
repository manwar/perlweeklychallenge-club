### https://theweeklychallenge.org/blog/perl-weekly-challenge-354/
"""

Task 1: Min Abs Diff

Submitted by: [72]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of distinct integers.

   Write a script to find all pairs of elements with the minimum absolute
   difference.
Rules (a,b):
1: a, b are from the given array.
2: a < b
3: b - a = min abs diff any two elements in the given array

Example 1

Input: @ints= (4, 2, 1, 3)
Output: [1, 2], [2, 3], [3, 4]

Example 2

Input: @ints = (10, 100, 20, 30)
Output: [10, 20], [20, 30]

Example 3

Input: @ints = (-5, -2, 0, 3)
Output: [-2, 0]

Example 4

Input: @ints = (8, 1, 15, 3)
Output: [1, 3]

Example 5

Input: @ints = (12, 5, 9, 1, 15)
Output: [9, 12], [12, 15]

Task 2: Shift Grid
"""
### solution by pokgopun@gmail.com

def mad(ints: tuple[int]) -> list[tuple[int]]:
    ints = sorted(ints)
    mn = ints[-1]-ints[0]
    pairs = []
    for i in range(1,len(ints)):
        b, a = ints[i], ints[i-1]
        d = b - a
        if mn == d:
            pairs.append((a,b))
        elif mn > d:
            mn = d
            pairs = [(a,b)]
    return pairs

import unittest

class TestMad(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
            (4, 2, 1, 3): [(1, 2), (2, 3), (3, 4)],
            (10, 100, 20, 30): [(10, 20), (20, 30)],
            (-5, -2, 0, 3): [(-2, 0)],
            (8, 1, 15, 3): [(1, 3)],
            (12, 5, 9, 1, 15): [(9, 12), (12, 15)],
            }.items():
            self.assertEqual(mad(inpt),otpt)

unittest.main()
