### https://theweeklychallenge.org/blog/perl-weekly-challenge-248/
"""

Task 2: Submatrix Sum

Submitted by: [59]Jorg Sommrey
     __________________________________________________________________

   You are given a NxM matrix A of integers.

   Write a script to construct a (N-1)x(M-1) matrix B having elements that
   are the sum over the 2x2 submatrices of A,
b[i,k] = a[i,k] + a[i,k+1] + a[i+1,k] + a[i+1,k+1]

Example 1

Input: $a = [
              [1,  2,  3,  4],
              [5,  6,  7,  8],
              [9, 10, 11, 12]
            ]

Output: $b = [
               [14, 18, 22],
               [30, 34, 38]
             ]

Example 2

Input: $a = [
              [1, 0, 0, 0],
              [0, 1, 0, 0],
              [0, 0, 1, 0],
              [0, 0, 0, 1]
            ]

Output: $b = [
               [2, 1, 0],
               [1, 2, 1],
               [0, 1, 2]
             ]
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 24th December
   2023.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def submatrixSum(tup: tuple):
    d = len(tup)
    l = len(tup[0])
    stup = tuple()
    for y in range(d-1):
        t = tuple()
        for x in range(l-1):
            t += ( sum( sum(tup[z][x:x+2]) for z in range(y,y+2) ), )
        stup += (t,)
    return stup

import unittest

class TestSubmatrixSum(unittest.TestCase):
    def test(self):
        for inpt,otpt in {
                (
                    (1,  2,  3,  4),
                    (5,  6,  7,  8),
                    (9, 10, 11, 12),
                    ): (
                        (14, 18, 22),
                        (30, 34, 38),
                        ),
                    (
                        (1, 0, 0, 0),
                        (0, 1, 0, 0),
                        (0, 0, 1, 0),
                        (0, 0, 0, 1)
                        ): (
                            (2, 1, 0),
                            (1, 2, 1),
                            (0, 1, 2),
                            ),
                        }.items():
            self.assertEqual(submatrixSum(inpt),otpt)

unittest.main()

 
