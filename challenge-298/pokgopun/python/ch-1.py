### https://theweeklychallenge.org/blog/perl-weekly-challenge-298/
"""

Task 1: Maximal Square

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an m x n binary matrix with 0 and 1 only.

   Write a script to find the largest square containing only 1's and
   return it’s area.

Example 1

Input: @matrix = ([1, 0, 1, 0, 0],
                  [1, 0, 1, 1, 1],
                  [1, 1, 1, 1, 1],
                  [1, 0, 0, 1, 0])
Output: 4

Two maximal square found with same size marked as 'x':

[1, 0, 1, 0, 0]
[1, 0, x, x, 1]
[1, 1, x, x, 1]
[1, 0, 0, 1, 0]

[1, 0, 1, 0, 0]
[1, 0, 1, x, x]
[1, 1, 1, x, x]
[1, 0, 0, 1, 0]

Example 2

Input: @matrix = ([0, 1],
                  [1, 0])
Output: 1

Two maximal square found with same size marked as 'x':

[0, x]
[1, 0]


[0, 1]
[x, 0]

Example 3

Input: @matrix = ([0])
Output: 0

Task 2: Right Interval
"""
### solution by pokgopun@gmail.com

from typing import Tuple,TypeAlias
from collections.abc import Generator
from dataclasses import dataclass

@dataclass
class Point:
    r: int
    c: int

@dataclass
class Square:
    start: Point
    end: Point

Row: TypeAlias = Tuple[int]

class Matrix:
    def __init__(self, rows: Tuple[Row]):
        self.rws = rows
        self.h = len(rows)
        self.w = len(rows[0])
    def square(self, length: int) -> Generator[Square]:
        for r in range(self.h - length + 1):
                for c in range(self.w - length + 1):
                    start = Point(r, c)
                    end = Point(r + length - 1, c + length - 1)
                    yield Square(start, end)
    def value(self, p: Point) -> int:
        return self.rws[p.r][p.c]
    def isFilled(self, sqr: Square) -> bool:
        r = sqr.start.r
        while r <= sqr.end.r:
            c = sqr.start.c
            while c <= sqr.end.c:
                if self.value(Point(r, c)) == 0:
                    return False
                c += 1
            r += 1
        return True
    def maximalSquare(self) -> int:
        l = min(self.h, self.w)
        while l > 0:
            for sqr in self.square(l):
                if self.isFilled(sqr):
                    return l * l
            l -= 1
        return 0

import unittest

class TestMaximalSquare(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (
                    (1, 0, 1, 0, 0),
                    (1, 0, 1, 1, 1),
                    (1, 1, 1, 1, 1),
                    (1, 0, 0, 1, 0),
                    ): 4,
                (
                    (0, 1),
                    (1, 0),
                    ): 1,
                (
                    (0,),
                    ): 0,
                }.items():
            self.assertEqual(Matrix(inpt).maximalSquare(), otpt)

unittest.main()
