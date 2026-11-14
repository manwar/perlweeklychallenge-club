#!/usr/bin/env python3
"""Reduced Row Echelon - Perl Weekly Challenge 257 task 2."""

from __future__ import annotations

import unittest


def is_reduced_row_echelon(matrix: list[list[int]]) -> int:
    """Return 1 if matrix is in reduced row echelon form, otherwise 0."""
    last_leading = -1
    zero_row_encountered = False

    for row_idx, row in enumerate(matrix):
        if all(x == 0 for x in row):
            zero_row_encountered = True
            continue

        if zero_row_encountered:
            return 0

        leading = next(i for i, x in enumerate(row) if x != 0)
        if row[leading] != 1 or leading <= last_leading:
            return 0

        if any(matrix[i][leading] != 0 for i in range(len(matrix)) if i != row_idx):
            return 0

        last_leading = leading

    return 1


class TestReducedRowEchelon(unittest.TestCase):
    """Unit tests for is_reduced_row_echelon."""

    def test_example_1(self) -> None:
        """Verify Example 1."""
        self.assertEqual(
            is_reduced_row_echelon([[1, 1, 0], [0, 1, 0], [0, 0, 0]]),
            0,
        )

    def test_example_2(self) -> None:
        """Verify Example 2."""
        self.assertEqual(
            is_reduced_row_echelon(
                [
                    [0, 1, -2, 0, 1],
                    [0, 0, 0, 1, 3],
                    [0, 0, 0, 0, 0],
                    [0, 0, 0, 0, 0],
                ]
            ),
            1,
        )

    def test_example_3(self) -> None:
        """Verify Example 3."""
        self.assertEqual(
            is_reduced_row_echelon([[1, 0, 0, 4], [0, 1, 0, 7], [0, 0, 1, -1]]),
            1,
        )

    def test_example_4(self) -> None:
        """Verify Example 4."""
        self.assertEqual(
            is_reduced_row_echelon(
                [
                    [0, 1, -2, 0, 1],
                    [0, 0, 0, 0, 0],
                    [0, 0, 0, 1, 3],
                    [0, 0, 0, 0, 0],
                ]
            ),
            0,
        )

    def test_example_5(self) -> None:
        """Verify Example 5."""
        self.assertEqual(
            is_reduced_row_echelon([[0, 1, 0], [1, 0, 0], [0, 0, 0]]),
            0,
        )

    def test_example_6(self) -> None:
        """Verify Example 6."""
        self.assertEqual(
            is_reduced_row_echelon([[4, 0, 0, 0], [0, 1, 0, 7], [0, 0, 1, -1]]),
            0,
        )


if __name__ == "__main__":
    unittest.main()
