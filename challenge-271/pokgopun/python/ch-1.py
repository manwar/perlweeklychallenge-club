### https://theweeklychallenge.org/blog/perl-weekly-challenge-271/
"""

Task 1: Maximum Ones

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a m x n binary matrix.

   Write a script to return the row number containing maximum ones, in
   case of more than one rows then return smallest row number.

Example 1

input: $matrix = [ [0, 1],
                   [1, 0],
                 ]
output: 1

row 1 and row 2 have the same number of ones, so return row 1.

example 2

input: $matrix = [ [0, 0, 0],
                   [1, 0, 1],
                 ]
output: 2

row 2 has the maximum ones, so return row 2.

example 3

input: $matrix = [ [0, 0],
                   [1, 1],
                   [0, 0],
                 ]
Output: 2

Row 2 have the maximum ones, so return row 2.

Task 2: Sort by 1 bits
"""
### solution by pokgopun@gmail.com

def maxOne(mtx: list):
    return 1 - max(
            (mtx[e].count(1),-e) for e in range(len(mtx))
            )[1]

import unittest

class TestMaxOne(unittest.TestCase):
    def test(self):
        for otpt, inpt in {
                1: [ [0, 1],
                   [1, 0],
                 ],
                2: [ [0, 0, 0],
                   [1, 0, 1],
                 ],
                2: [ [0, 0],
                   [1, 1],
                   [0, 0],
                 ],
                }.items():
            self.assertEqual(maxOne(inpt),otpt)

unittest.main()
