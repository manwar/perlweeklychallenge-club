### https://theweeklychallenge.org/blog/perl-weekly-challenge-327/
"""

Task 2: MAD

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of distinct integers.

   Write a script to find all pairs of elements with minimum absolute
   difference (MAD) of any two elements.

Example 1

Input: @ints = (4, 1, 2, 3)
Output: [1,2], [2,3], [3,4]

The minimum absolute difference is 1.
Pairs with MAD: [1,2], [2,3], [3,4]

Example 2

Input: @ints = (1, 3, 7, 11, 15)
Output: [1,3]

Example 3

Input: @ints = (1, 5, 3, 8)
Output: [1,3], [3,5]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 29th June 2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def mad(ints: tuple[int]) -> list[tuple[int]]:
    ints = sorted(ints)
    l = len(ints)
    mn = ints[1] - ints[0]
    i = l
    while i > 2:
        i -= 1
        m = ints[i] - ints[i-1]
        if mn > m:
            mn = m
    lst = []
    for i in range(l-1):
        for j in range(i+1,l):
            if ints[j] - ints[i] == mn:
                lst.append((ints[i],ints[j]))
    return lst

import unittest

class TestMad(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (4, 1, 2, 3): [(1,2), (2,3), (3,4)],
                (1, 3, 7, 11, 15): [(1,3)],
                (1, 5, 3, 8): [(1,3), (3,5)],
                }.items():
            self.assertEqual(mad(inpt),otpt)

unittest.main()
