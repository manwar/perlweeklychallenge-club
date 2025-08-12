### https://theweeklychallenge.org/blog/perl-weekly-challenge-334/
"""

Task 2:

Submitted by: [51]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given current location as two integers: x and y. You are also
   given a list of points on the grid.

   A point is considered valid if it shares either the same x-coordinate
   or the same y-coordinate as the current location.

   Write a script to return the index of the valid point that has the
   smallest Manhattan distance to the current location. If multiple valid
   points are tied for the smallest distance, return the one with the
   lowest index. If no valid points exist, return -1.

     The Manhattan distance between two points (x1, y1) and (x2, y2) is
     calculated as: |x1 - x2| + |y1 - y2|

Example 1

Input: $x = 3, $y = 4, @points ([1, 2], [3, 1], [2, 4], [2, 3])
Output: 2

Valid points: [3, 1] (same x), [2, 4] (same y)

Manhattan distances:
    [3, 1] => |3-3| + |4-1| = 3
    [2, 4] => |3-2| + |4-4| = 1

Closest valid point is [2, 4] at index 2.

Example 2

Input: $x = 2, $y = 5, @points ([3, 4], [2, 3], [1, 5], [2, 5])
Output: 3

Valid points: [2, 3], [1, 5], [2, 5]

Manhattan distances:
    [2, 3] => 2
    [1, 5] => 1
    [2, 5] => 0

Closest valid point is [2, 5] at index 3.

Example 3

Input: $x = 1, $y = 1, @points ([2, 2], [3, 3], [4, 4])
Output: -1

No point shares x or y with (1, 1).

Example 4

Input: $x = 0, $y = 0, @points ([0, 1], [1, 0], [0, 2], [2, 0])
Output: 0

Valid points: all of them

Manhattan distances:
    [0, 1] => 1
    [1, 0] => 1
    [0, 2] => 2
    [2, 0] => 2

Tie between index 0 and 1, pick the smaller index: 0

Example 5

Input: $x = 5, $y = 5, @points ([5, 6], [6, 5], [5, 4], [4, 5])
Output: 0

Valid points: all of them
    [5, 6] => 1
    [6, 5] => 1
    [5, 4] => 1
    [4, 5] => 1

All tie, return the one with the lowest index: 0
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 17th August
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from dataclasses import dataclass

@dataclass
class Point:
    x: int
    y: int

def mmd(x: int, y: int, ps: tuple[Point]) -> int:
    return list(
            [e[1] for e in sorted(
                (abs(ps[i]. x-x) + abs(ps[i]. y-y), i) for i in range(len(ps)) if ps[i].x==x or ps[i].y==y
                )
             ] + [-1]
            )[0]

import unittest

class TestMmd(unittest.TestCase):
    def test(self):
        for (x, y, ps), otpt in {
                (3, 4, ((1, 2), (3, 1), (2, 4), (2, 3))): 2,
                (2, 5, ((3, 4), (2, 3), (1, 5), (2, 5))): 3,
                (1, 1, ((2, 2), (3, 3), (4, 4))): -1,
                (0, 0, ((0, 1), (1, 0), (0, 2), (2, 0))): 0,
                }.items():
            self.assertEqual(mmd(x, y, tuple(Point(e[0],e[1]) for e in ps)), otpt)

unittest.main()
