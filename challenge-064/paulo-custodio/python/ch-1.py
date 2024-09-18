#!/usr/bin/env python3

# Challenge 064
#
# TASK #1 > Minimum Sum Path
# Submitted by: Mohammad S Anwar
# Reviewed by: Ryan Thompson
#
# Given an m x n matrix with non-negative integers, write a script to find a
# path from top left to bottom right which minimizes the sum of all numbers
# along its path. You can only move either down or right at any point in time.
#
# Example
# Input:
#
# [ 1 2 3 ]
# [ 4 5 6 ]
# [ 7 8 9 ]
# The minimum sum path looks like this:
#
# 1?2?3
#     ?
#     6
#     ?
#     9
# Thus, your script could output: 21 ( 1 ? 2 ? 3 ? 6 ? 9 )

import unittest
import sys

def min_sum(m):
    min_sum = [sys.maxsize]  # Using a list to simulate a global variable

    def min_sum1(sum, r, c, m):
        rows = len(m)
        cols = len(m[0])
        sum += m[r][c]
        if r == rows - 1 and c == cols - 1:  # reached end
            if sum < min_sum[0]:
                min_sum[0] = sum
        else:
            if r + 1 < rows:
                min_sum1(sum, r + 1, c, m)
            if c + 1 < cols:
                min_sum1(sum, r, c + 1, m)

    min_sum1(0, 0, 0, m)
    return min_sum[0]

class TestMinSum(unittest.TestCase):
    def test_min_sum(self):
        m = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]
        ]
        self.assertEqual(min_sum(m), 21)

if __name__ == '__main__':
    unittest.main()
