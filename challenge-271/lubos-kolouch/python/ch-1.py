#!/usr/bin/env python3
"""Maximum Ones - Perl Weekly Challenge 271 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import json
import sys
import unittest


def maximum_ones(matrix: Sequence[Sequence[int]]) -> int:
    """Return 1-based index of row with maximum ones (ties -> smallest index)."""
    if not matrix:
        raise ValueError("Expected a non-empty matrix")

    best_row = 1
    best_count = -1
    for i, row in enumerate(matrix, start=1):
        count = sum(row)
        if count > best_count:
            best_count = count
            best_row = i
    return best_row


class MaximumOnesExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(maximum_ones(((0, 1), (1, 0))), 1)

    def test_example_2(self) -> None:
        self.assertEqual(maximum_ones(((0, 0, 0), (1, 0, 1))), 2)

    def test_example_3(self) -> None:
        self.assertEqual(maximum_ones(((0, 0), (1, 1), (0, 0))), 2)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    if len(args) != 1:
        raise SystemExit("Usage: python3 ch-1.py '<json-matrix>'")
    matrix = json.loads(args[0])
    print(f"Output: {maximum_ones(matrix)}")


if __name__ == "__main__":
    main()

