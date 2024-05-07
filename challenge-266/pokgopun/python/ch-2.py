### https://theweeklychallenge.org/blog/perl-weekly-challenge-266/
"""

Task 2: X Matrix

Submitted by: [42]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a square matrix, $matrix.

   Write a script to find if the given matrix is X Matrix.

     A square matrix is an X Matrix if all the elements on the main
     diagonal and antidiagonal are non-zero and everything else are zero.

Example 1

Input: $matrix = [ [1, 0, 0, 2],
                   [0, 3, 4, 0],
                   [0, 5, 6, 0],
                   [7, 0, 0, 1],
                 ]
Output: true

Example 2

Input: $matrix = [ [1, 2, 3],
                   [4, 5, 6],
                   [7, 8, 9],
                 ]
Output: false

Example 3

Input: $matrix = [ [1, 0, 2],
                   [0, 3, 0],
                   [4, 0, 5],
                 ]
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 28th April
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

def hasAllZero(arr):
    return 

def mtxIsValid(mtx: list):
    l = len(mtx)
    if l < 3:
        return None
    h = l // 2
    col = 0
    lst = list()
    for row in range(h):
        for r in (row,-row-1):
            lst = [e for e in mtx[r]]
            if len(lst) != l:
                return None
            for c in (col,-col-1):
                if lst[c] == 0:
                    return False
                lst[c] = 0
            for e in lst:
                if e != 0:
                    return False
        col += 1
    if h % 2:
        lst = [e for e in mtx[h]]
        if len(lst) != l:
            return None
        if mtx[h][h] == 0:
            return False
        lst[h] = 0
        for e in lst:
            if e != 0:
                return False
    return True

import unittest

class TestMtxIsValid(unittest.TestCase):
    def test(self):
        for ans, mtx in {
                True: [ [1, 0, 0, 2],
                    [0, 3, 4, 0],
                    [0, 5, 6, 0],
                    [7, 0, 0, 1],],
                False: [ [1, 2, 3],
                    [4, 5, 6],
                    [7, 8, 9],],
                True: [ [1, 0, 2],
                    [0, 3, 0],
                    [4, 0, 5],],
                }.items():
            self.assertEqual(ans,mtxIsValid(mtx))

unittest.main()
