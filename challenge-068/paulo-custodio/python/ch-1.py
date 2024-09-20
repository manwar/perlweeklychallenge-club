#!/usr/bin/env python3

# Challenge 068
#
# TASK #1 > Zero Matrix
# Submitted by: Mohammad S Anwar
# You are given a matrix of size M x N having only 0s and 1s.
#
# Write a script to set the entire row and column to 0 if an element is 0.
#
# Example 1
# Input: [1, 0, 1]
#        [1, 1, 1]
#        [1, 1, 1]
#
# Output: [0, 0, 0]
#         [1, 0, 1]
#         [1, 0, 1]
# Example 2
# Input: [1, 0, 1]
#        [1, 1, 1]
#        [1, 0, 1]
#
# Output: [0, 0, 0]
#         [1, 0, 1]
#         [0, 0, 0]

from copy import deepcopy
import unittest

def zero_matrix(m):
    orig = deepcopy(m)
    for r in range(len(m)):
        for c in range(len(m[0])):
            if not orig[r][c]:
                m = zero_row(r, m)
                m = zero_col(c, m)
    return m

def zero_row(r, m):
    for c in range(len(m[0])):
        m[r][c] = 0
    return m

def zero_col(c, m):
    for r in range(len(m)):
        m[r][c] = 0
    return m

class TestZeroMatrix(unittest.TestCase):
    def test_zero_matrix(self):
        self.assertEqual(zero_matrix([[1, 0, 1], [1, 1, 1], [1, 1, 1]]), [[0, 0, 0], [1, 0, 1], [1, 0, 1]])
        self.assertEqual(zero_matrix([[1, 0, 1], [1, 1, 1], [1, 0, 1]]), [[0, 0, 0], [1, 0, 1], [0, 0, 0]])

if __name__ == '__main__':
    unittest.main()
