### https://theweeklychallenge.org/blog/perl-weekly-challenge-333/
"""

Task 1: Straight Line

Submitted by: [43]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a list of co-ordinates.

   Write a script to find out if the given points make a straight line.

Example 1

Input: @list = ([2, 1], [2, 3], [2, 5])
Output: true

Example 2

Input: @list = ([1, 4], [3, 4], [10, 4])
Output: true

Example 3

Input: @list = ([0, 0], [1, 1], [2, 3])
Output: false

Example 4

Input: @list = ([1, 1], [1, 1], [1, 1])
Output: true

Example 5

Input: @list = ([1000000, 1000000], [2000000, 2000000], [3000000, 3000000])
Output: true

Task 2: Duplicate Zeros
"""
### solution by pokgopun@gmail.com

from typing import Self

class Point:
    def __init__(self, x: int, y: int):
        self.x = x
        self.y = y
    def slope(self, p: Self) -> Self:
        return Slope(self.y - p.y, self.x - p.x)

class Slope:
    def __init__(self, y: int, x: int):
        self.y = y
        self.x = x
    def isEqual(self, s: Self) -> bool:
        return self.x * s.y == self.y * s.x

def sl(lst: tuple[tuple[int]]) -> bool:
    i = len(lst) - 1
    if i < 2:
        return true
    p0 = Point(lst[0][0],lst[0][1])
    p1 = Point(lst[1][0],lst[1][1])
    s0 = p0.slope(p1)
    while i > 1:
        p = Point(lst[i][0],lst[i][1])
        if not s0.isEqual(p0.slope(p)):
            return False
        i -= 1
    return True

import unittest

class TestSl(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                ((2, 1), (2, 3), (2, 5)): True,
                ((1, 4), (3, 4), (10, 4)): True,
                ((0, 0), (1, 1), (2, 3)): False,
                ((1, 1), (1, 1), (1, 1)): True,
                ((1000000, 1000000), (2000000, 2000000), (3000000, 3000000)): True,
                }.items():
            self.assertEqual(sl(inpt), otpt)

unittest.main()
