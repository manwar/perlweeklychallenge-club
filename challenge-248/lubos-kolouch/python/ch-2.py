#!/usr/bin/env python3
"""Submatrix Sum - Perl Weekly Challenge 248, Task 2."""

from __future__ import annotations

import unittest


def construct_matrix(matrix: list[list[int]]) -> list[list[int]]:
    """Construct the (N-1)x(M-1) matrix of 2x2 submatrix sums."""
    if len(matrix) < 2 or len(matrix[0]) < 2:
        return []

    rows, cols = len(matrix), len(matrix[0])
    return [
        [
            sum(matrix[i + di][j + dj] for di in range(2) for dj in range(2))
            for j in range(cols - 1)
        ]
        for i in range(rows - 1)
    ]


class TestConstructMatrix(unittest.TestCase):
    """Unit tests for the construct_matrix function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[list[list[int]], list[list[int]]]] = [
            (
                [[1, 2, 3, 4], [5, 6, 7, 8], [9, 10, 11, 12]],
                [[14, 18, 22], [30, 34, 38]],
            ),
            (
                [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]],
                [[2, 1, 0], [1, 2, 1], [0, 1, 2]],
            ),
        ]
        for matrix, expected in cases:
            with self.subTest(matrix=matrix):
                self.assertEqual(construct_matrix(matrix), expected)


if __name__ == "__main__":
    unittest.main()
