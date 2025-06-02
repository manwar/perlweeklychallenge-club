### https://theweeklychallenge.org/blog/perl-weekly-challenge-324/
"""

Task 1: 2D Array

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of integers and two integers $r amd $c.

   Write a script to create two dimension array having $r rows and $c
   columns using the given array.

Example 1

Input: @ints = (1, 2, 3, 4), $r = 2, $c = 2
Output: ([1, 2], [3, 4])

Example 2

Input: @ints = (1, 2, 3), $r = 1, $c = 3
Output: ([1, 2, 3])

Example 3

Input: @ints = (1, 2, 3, 4), $r = 4, $c = 1
Output: ([1], [2], [3], [4])

Task 2: Total XOR
"""
### solution by pokgopun@gmail.com

def tda(ints: tuple[int], r: int, c: int) -> tuple[list[int]]:
    return tuple(list(ints[i*c:i*c+c]) for i in range(r))

import unittest

class TestTda(unittest.TestCase):
    def test(self):
        for (ints, r, c), otpt in {
                ((1, 2, 3, 4), 2, 2): ([1, 2], [3, 4]),
                ((1, 2, 3), 1, 3): ([1, 2, 3],),
                ((1, 2, 3, 4), 4, 1): ([1], [2], [3], [4]),
                }.items():
            self.assertEqual(tda(ints,r,c), otpt)

unittest.main()
