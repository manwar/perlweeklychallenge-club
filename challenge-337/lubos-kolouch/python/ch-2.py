"""
This script solves the Perl Weekly Challenge 337, Task 2.

Task 2: Odd Matrix

You are given `row` and `col`, also a list of positions in the matrix.

Write a script to perform action on each location (0-indexed) as provided in
the list and find out the total odd valued cells.

For each location (r, c), do both of the following:
a) Increment by 1 all the cells on row r.
b) Increment by 1 all the cells on column c.

Example 1
Input: `$row = 2, $col = 3, @locations = ([0,1],[1,1])`
Output: 6

Example 2
Input: `$row = 2, $col = 2, @locations = ([1,1],[0,0])`
Output: 0

Example 3
Input: `$row = 3, $col = 3, @locations = ([0,0],[1,2],[2,1])`
Output: 0
"""

import unittest


def odd_matrix(row: int, col: int, locations: list[list[int]]) -> int:
    """
    Given a matrix of size row x col, and a list of locations, increment the
    row and column for each location and count the odd cells.
    """
    matrix = [[0 for _ in range(col)] for _ in range(row)]

    for r, c in locations:
        for i in range(col):
            matrix[r][i] += 1
        for i in range(row):
            matrix[i][c] += 1

    odd_cells = 0
    for r in range(row):
        for c in range(col):
            if matrix[r][c] % 2 != 0:
                odd_cells += 1

    return odd_cells


class TestOddMatrix(unittest.TestCase):

    def test_example1(self):
        self.assertEqual(odd_matrix(2, 3, [[0, 1], [1, 1]]), 6)

    def test_example2(self):
        self.assertEqual(odd_matrix(2, 2, [[1, 1], [0, 0]]), 0)

    def test_example3(self):
        self.assertEqual(odd_matrix(3, 3, [[0, 0], [1, 2], [2, 1]]), 0)


if __name__ == '__main__':
    unittest.main()
