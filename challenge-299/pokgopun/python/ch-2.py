### https://theweeklychallenge.org/blog/perl-weekly-challenge-299/
"""

Task 2: Word Search

Submitted by: [50]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a grid of characters and a string.

   Write a script to determine whether the given string can be found in
   the given grid of characters. You may start anywhere and take any
   orthogonal path, but may not reuse a grid cell.

Example 1

Input: @chars = (['A', 'B', 'D', 'E'],
                 ['C', 'B', 'C', 'A'],
                 ['B', 'A', 'A', 'D'],
                 ['D', 'B', 'B', 'C'])
      $str = 'BDCA'
Output: true

Example 2

Input: @chars = (['A', 'A', 'B', 'B'],
                 ['C', 'C', 'B', 'A'],
                 ['C', 'A', 'A', 'A'],
                 ['B', 'B', 'B', 'B'])
      $str = 'ABAC'
Output: false

Example 3

Input: @chars = (['B', 'A', 'B', 'A'],
                 ['C', 'C', 'C', 'C'],
                 ['A', 'B', 'A', 'B'],
                 ['B', 'B', 'A', 'A'])
      $str = 'CCCAA'
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 15^th December
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from typing import TypeAlias,Tuple

class Point:
    def __init__(self, r: int, c:int):
        self.r = r
        self.c = c
    def __eq__(self, other):
        return self.r == other.r and self.c == other.c
    def __str__(self):
        return f'Point(x={self.r},y={self.c})'
    def __repr__(self):
        return f'({self.r},{self.c})'

Row: TypeAlias = Tuple[str]

class Chars:
    def __init__(self, rws: Tuple[Row], string: str):
        self.rws = rws
        self.h = len(rws)
        self.w = len(rws[0])
        self.string = string
        self.l = len(string)
        self.stringPoints = [None for i in range(self.l)]
        self.stringExists = False
        for r in range(self.h):
            for c in range(self.w):
                if rws[r][c] == string[0]:
                    self.stringPoints[0] = Point(r, c)
                    if self.process(1) == self.l:
                        #print(self.stringPoints)   ### __repr__ will be used, not __str__
                        '''
                        for p in self.stringPoints:
                            print(p)   ### __str__ will be used if present. if it is not present, __repr__ will then be used
                        '''
                        self.stringExists = True
                        return
    def adjacentPoints(self, p: Point) -> Tuple[Point]:
        points: List[Point] = []
        if p.r > 0:
            points.append(Point(p.r - 1, p.c))
        if p.c > 0:
            points.append(Point(p.r, p.c - 1))
        if p.r < self.h - 1:
            points.append(Point(p.r + 1, p.c))
        if p.c < self.w - 1:
            points.append(Point(p.r, p.c + 1))
        return points
    def process(self, idx: int) -> int:
        if idx < self.l:
            for p in self.adjacentPoints(self.stringPoints[idx - 1]):
                if self.rws[p.r][p.c] == self.string[idx]:
                    try:
                        self.stringPoints[:idx].index(p)
                    except:
                        self.stringPoints[idx] = p
                        if self.process(idx + 1) == self.l:
                            return self.l
        return idx

import unittest

class TestChars(unittest.TestCase):
    def test(self):
        for (chars, string), otpt in {
                (
                    (
                        ('A', 'B', 'D', 'E'),
                        ('C', 'B', 'C', 'A'),
                        ('B', 'A', 'A', 'D'),
                        ('D', 'B', 'B', 'C'),
                        ), 'BDCA',
                    ): True,
                (
                    (
                        ('A', 'A', 'B', 'B'),
                        ('C', 'C', 'B', 'A'),
                        ('C', 'A', 'A', 'A'),
                        ('B', 'B', 'B', 'B'),
                        ), 'ABAC', 
                    ):False,
                (
                    (
                        ('B', 'A', 'B', 'A'),
                        ('C', 'C', 'C', 'C'),
                        ('A', 'B', 'A', 'B'),
                        ('B', 'B', 'A', 'A'),
                        ), 'CCCAA',
                    ): True,
                }.items():
            #print(string, otpt)
            self.assertEqual(Chars(chars, string).stringExists, otpt)

unittest.main()
