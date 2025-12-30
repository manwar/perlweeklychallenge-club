#!/usr/bin/env python3
"""Shift Grid - Perl Weekly Challenge 354 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


Matrix = list[list[int]]


def shift_grid(matrix: Sequence[Sequence[int]], k: int) -> Matrix:
    """Return the matrix shifted k times following the wrap rules."""
    if k <= 0:
        raise ValueError("Expected k > 0")
    if not matrix:
        return []
    rows = len(matrix)
    cols = len(matrix[0])
    if any(len(row) != cols for row in matrix):
        raise ValueError("Non-rectangular matrix")

    flat = [value for row in matrix for value in row]
    length = len(flat)
    shift = k % length
    if shift:
        flat = flat[-shift:] + flat[:-shift]

    return [flat[r * cols : (r + 1) * cols] for r in range(rows)]


class ShiftGridExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(
            shift_grid(((1, 2, 3), (4, 5, 6), (7, 8, 9)), 1),
            [[9, 1, 2], [3, 4, 5], [6, 7, 8]],
        )

    def test_example_2(self) -> None:
        self.assertEqual(shift_grid(((10, 20), (30, 40)), 1), [[40, 10], [20, 30]])

    def test_example_3(self) -> None:
        self.assertEqual(shift_grid(((1, 2), (3, 4), (5, 6)), 1), [[6, 1], [2, 3], [4, 5]])

    def test_example_4(self) -> None:
        self.assertEqual(shift_grid(((1, 2, 3), (4, 5, 6)), 5), [[2, 3, 4], [5, 6, 1]])

    def test_example_5(self) -> None:
        self.assertEqual(shift_grid(((1, 2, 3, 4),), 1), [[4, 1, 2, 3]])


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 2:
        raise SystemExit('Usage: python3 ch-2.py <k> "row1;row2;..." (rows are comma-separated)')

    k = int(args[0])
    rows = [[int(token) for token in row.split(",")] for row in args[1].split(";")]
    print(shift_grid(rows, k))


if __name__ == "__main__":
    main()
