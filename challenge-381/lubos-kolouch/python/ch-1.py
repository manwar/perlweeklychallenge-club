#!/usr/bin/env python3
"""Same Row Column - Perl Weekly Challenge 381 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def same_row_column(matrix: list[list[int]]) -> bool:
    """Return True if every row and every column contains all integers from 1 to n."""
    n = len(matrix)

    # Check rows
    for row in matrix:
        if len(row) != n:
            return False
        if set(row) != set(range(1, n + 1)):
            return False

    # Check columns
    for col_idx in range(n):
        col = [matrix[row_idx][col_idx] for row_idx in range(n)]
        if set(col) != set(range(1, n + 1)):
            return False

    return True


class SameRowColumnExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertTrue(
            same_row_column(
                [
                    [1, 2, 3, 4],
                    [2, 3, 4, 1],
                    [3, 4, 1, 2],
                    [4, 1, 2, 3],
                ]
            )
        )

    def test_example_2(self) -> None:
        self.assertTrue(same_row_column([[1]]))

    def test_example_3(self) -> None:
        self.assertFalse(
            same_row_column(
                [
                    [1, 2, 5],
                    [5, 1, 2],
                    [2, 5, 1],
                ]
            )
        )

    def test_example_4(self) -> None:
        self.assertFalse(
            same_row_column(
                [
                    [1, 2, 3],
                    [1, 2, 3],
                    [1, 2, 3],
                ]
            )
        )

    def test_example_5(self) -> None:
        self.assertFalse(
            same_row_column(
                [
                    [1, 2, 3],
                    [3, 1, 2],
                    [3, 2, 1],
                ]
            )
        )


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-1.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
