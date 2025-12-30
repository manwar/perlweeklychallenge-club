#!/usr/bin/env python3
"""Maximal Square - Perl Weekly Challenge 298 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def maximal_square_area(matrix: Sequence[Sequence[int]]) -> int:
    """Return the area of the largest all-1s square in the 0/1 matrix."""
    if not matrix:
        return 0
    rows = len(matrix)
    cols = len(matrix[0])
    if any(len(row) != cols for row in matrix):
        raise ValueError("Non-rectangular matrix")

    dp = [[0] * cols for _ in range(rows)]
    best = 0

    for r in range(rows):
        for c in range(cols):
            value = matrix[r][c]
            if value not in (0, 1):
                raise ValueError("Matrix must contain only 0 and 1")
            if value == 0:
                continue
            if r == 0 or c == 0:
                dp[r][c] = 1
            else:
                dp[r][c] = 1 + min(dp[r - 1][c], dp[r][c - 1], dp[r - 1][c - 1])
            best = max(best, dp[r][c])

    return best * best


class MaximalSquareExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        matrix = (
            (1, 0, 1, 0, 0),
            (1, 0, 1, 1, 1),
            (1, 1, 1, 1, 1),
            (1, 0, 0, 1, 0),
        )
        self.assertEqual(maximal_square_area(matrix), 4)

    def test_example_2(self) -> None:
        self.assertEqual(maximal_square_area(((0, 1), (1, 0))), 1)

    def test_example_3(self) -> None:
        self.assertEqual(maximal_square_area(((0,),)), 0)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    _ = argv
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main()
