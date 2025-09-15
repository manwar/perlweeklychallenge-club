### https://theweeklychallenge.org/blog/perl-weekly-challenge-339/
"""

Task 1: Max Diff

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers having four or more elements.

   Write a script to find two pairs of numbers from this list (four
   numbers total) so that the difference between their products is as
   large as possible.

   In the end return the max difference.

     With Two pairs (a, b) and (c, d), the product difference is (a * b)
     - (c * d).

Example 1

Input: @ints = (5, 9, 3, 4, 6)
Output: 42

Pair 1: (9, 6)
Pair 2: (3, 4)
Product Diff: (9 * 6) - (3 * 4) => 54 - 12 => 42

Example 2

Input: @ints = (1, -2, 3, -4)
Output: 8

Pair 1: (3, 1)
Pair 2: (-2, -4)

Example 3

Input: @ints = (-3, -1, -2, -4)
Output: 10

Pair 1: (-1, -2)
Pair 2: (-3, -4)

Example 4

Input: @ints = (10, 2, 0, 5, 1)
Output: 50

Pair 1: (10, 5)
Pair 2: (0, 1)

Example 5

Input: @ints = (7, 8, 9, 10, 10)
Output: 44

Pair 1: (10, 10)
Pair 2: (7, 8)

Task 2: Peak Point
"""
### solution by pokgopun@gmail.com

from itertools import combinations

def md(ints: tuple[int]) -> int:
    mx, pair = None, None
    pairs = combinations(range(len(ints)),2)
    for ps in combinations(pairs,2):
        p1, p2 = ps[0], ps[1]
        if len(set(p1+p2)) != 4:
            continue
        v1, v2 = tuple(ints[i] for i in p1), tuple(ints[i] for i in p2)
        v = abs(v1[0]*v1[1] - v2[0]*v2[1])
        if mx == None or mx < v:
            mx = v
            pair = (v1,v2)
    #print(pair, mx)
    return mx

import unittest

class TestMd(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (5, 9, 3, 4, 6): 42,
                (1, -2, 3, -4): 10,
                (-3, -1, -2, -4): 10,
                (10, 2, 0, 5, 1): 50,
                (7, 8, 9, 10, 10): 44,
                }.items():
            self.assertEqual(md(inpt),otpt)

unittest.main()
