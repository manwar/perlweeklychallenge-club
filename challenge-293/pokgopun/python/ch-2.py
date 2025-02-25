### https://theweeklychallenge.org/blog/perl-weekly-challenge-293/
"""

Task 2: Boomerang

Submitted by: [41]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of points, (x, y).

   Write a script to find out if the given points are a boomerang.

     A boomerang is a set of three points that are all distinct and not
     in a straight line.

Example 1

Input: @points = ( [1, 1], [2, 3], [3,2] )
Output: true

Example 2

Input: @points = ( [1, 1], [2, 2], [3, 3] )
Output: false

Example 3

Input: @points = ( [1, 1], [1, 2], [2, 3] )
Output: true

Example 4

Input: @points = ( [1, 1], [1, 2], [1, 3] )
Output: false

Example 5

Input: @points = ( [1, 1], [2, 1], [3, 1] )
Output: false

Example 6

Input: @points = ( [0, 0], [2, 3], [4, 5] )
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 3rd November
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from typing import Tuple

def isBoomerang(points:Tuple[Tuple[int]]):
    l = len(points)
    if len(set(points)) != l or len(set(p[0] for p in points)) == 1 or len(set(p[1] for p in points)) == 1:
        return False
    deltas = []
    for i in range(l-1):
        for j in range(i+1,l):
            deltas.append((points[i][0] - points[j][0], points[i][1] - points[j][1]))
    #print(points, deltas)
    l = len(deltas)
    for i in range(l-1):
        for j in range(i+1,l):
            if deltas[i][0]*deltas[j][1] != deltas[i][1]*deltas[j][0]:
                return True
    return False

import unittest

class TestBoomerang(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                ( (1, 1), (2, 3), (3,2) ): True,
                ( (1, 1), (2, 2), (3, 3) ): False,
                ( (1, 1), (1, 2), (2, 3) ): True,
                ( (1, 1), (1, 2), (1, 3) ): False,
                ( (1, 1), (2, 1), (3, 1) ): False,
                ( (0, 0), (2, 3), (4, 5) ): True,
                }.items():
            self.assertEqual(isBoomerang(inpt), otpt)

unittest.main()
