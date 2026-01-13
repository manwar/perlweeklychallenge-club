#!/usr/bin/env python3
"""Summations - Perl Weekly Challenge 163 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def summations(values: Sequence[int]) -> int:
    """Compute summations as described in the task and return the final value."""
    row = [int(x) for x in values]
    while len(row) > 1:
        for i in range(2, len(row)):
            row[i] += row[i - 1]
        row = row[1:]
    return row[0]


class SummationsExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(summations((1, 2, 3, 4, 5)), 42)

    def test_example_2(self) -> None:
        self.assertEqual(summations((1, 3, 5, 7, 9)), 70)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    values = [int(token) for token in args]
    print(f"Input:  @n = ({', '.join(str(x) for x in values)})")
    print(f"Output: {summations(values)}")


if __name__ == "__main__":
    main()

