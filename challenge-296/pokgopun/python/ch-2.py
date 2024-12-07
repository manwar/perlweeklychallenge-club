### https://theweeklychallenge.org/blog/perl-weekly-challenge-296/
"""

Task 2: Matchstick Square

Submitted by: [46]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers, @ints.

   Write a script to find if it is possible to make one square using the
   sticks as in the given array @ints where $ints[ì] is the length of ith
   stick.

Example 1

Input: @ints = (1, 2, 2, 2, 1)
Output: true

Top: $ints[1] = 2
Bottom: $ints[2] = 2
Left: $ints[3] = 2
Right: $ints[0] and $ints[4] = 2

Example 2

Input: @ints = (2, 2, 2, 4)
Output: false

Example 3

Input: @ints = (2, 2, 2, 2, 4)
Output: false

Example 4

Input: @ints = (3, 4, 1, 4, 3, 1)
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 24th November
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from typing import Tuple
from itertools import combinations

def mss(ints: Tuple[int], n: int) -> bool:
    l = len(ints)
    if n == 1:
        return l > 0
    if l == 0:
        return n == 0
    if l < n:
        return False
    if l == n:
        return len(set(ints)) == 1
    sm = sum(ints)
    sl = sm // n
    if sl * n != sm:
        return False
    for r in range(1, l - n + 2):
        for cmb in combinations(range(l), r):
            if sum(ints[i] for i in cmb) != sl:
                continue
            new_ints = tuple(ints[i] for i in range(l) if i not in cmb)
            #print(r, cmb, "=>", new_ints, n)
            if mss(new_ints, n - 1):
                return True
    return False

def matchStickSquare(ints: Tuple[int]) -> bool:
    return mss(ints, 4)

def matchStickTriangle(ints: Tuple[int]) -> bool:
    return mss(ints, 3)

def matchStickDuo(ints: Tuple[int]) -> bool:
    return mss(ints, 2)

import unittest

class TestMss(unittest.TestCase):
    def testMatchStickSquare(self):
        for inpt, otpt in {
                (1, 2, 2, 2, 1): True,
                (2, 2, 2, 4): False,
                (2, 2, 2, 2, 4): False,
                (3, 4, 1, 4, 3, 1): True,
                }.items():
            self.assertEqual(matchStickSquare(inpt), otpt)
    def testMatchStickTriangle(self):
        for inpt, otpt in {
                (1, 2, 2, 1): True,
                (3, 2, 3, 1): True,
                (1, 2, 1, 2, 4): False,
                (2, 1, 1, 2, 2, 1): True,
                }.items():
            #print(inpt, otpt)
            self.assertEqual(matchStickTriangle(inpt), otpt)
    def testMatchStickDuo(self):
        for inpt, otpt in {
                (1, 2, 2, 1): True,
                (3, 2, 3, 1): False,
                (1, 2, 1, 2, 4): True,
                (2, 1, 1, 2, 2, 1): False,
                }.items():
            #print(inpt, otpt)
            self.assertEqual(matchStickDuo(inpt), otpt)

unittest.main()
