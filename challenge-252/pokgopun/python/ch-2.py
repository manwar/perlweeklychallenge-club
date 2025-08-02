### https://theweeklychallenge.org/blog/perl-weekly-challenge-252/
"""

Task 2: Unique Sum Zero

Submitted by: [46]Mohammad S Anwar
     __________________________________________________________________

   You are given an integer, $n.

   Write a script to find an array containing $n unique integers such that
   they add up to zero.

Example 1

Input: $n = 5
Output: (-7, -1, 1, 3, 4)

Two other possible solutions could be as below:
(-5, -1, 1, 2, 3) and (-3, -1, 2, -2, 4).

Example 2

Input: $n = 3
Output: (-1, 0, 1)

Example 3

Input: $n = 1
Output: (0)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 21st January
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from itertools import combinations

def isUsz(n: int, tup: tuple):
    # assuming array member is less than n, the min value for the member will be -(1 + .. + n - 1) 
    p = range(-sum(i for i in range(1,n)), n)
    return set(tup) in ( set(cmb) for cmb in combinations(p,n) if sum(cmb)==0 )

import unittest

class TestIsUsz(unittest.TestCase):
    def test1(self):
        for n,tup in {
                5: (-7, -1, 1, 3, 4),
                5: (-5, -1, 1, 2, 3),
                5: (-3, -1, 2, -2, 4),
                3: (-1, 0, 1),
                1: (0,),
                }.items():
            self.assertEqual(isUsz(n,tup),True)
    def test2(self):
        for n,tup in {
                5: (-1, 0, 1, 2, 3),
                5: (-2, -1, 0, 1, 3),
                5: (-3, -1, 0, 1, 2),
                3: (-2, 0, 1),
                1: (1,),
                }.items():
            self.assertEqual(isUsz(n,tup),False)

unittest.main()
