#!/usr/bin/env python3
"""Largest Number - Perl Weekly Challenge 301 task 1."""

from __future__ import annotations

from collections.abc import Sequence
from functools import cmp_to_key
import sys
import unittest


def _compare(a: str, b: str) -> int:
    ab = a + b
    ba = b + a
    if ab > ba:
        return -1
    if ab < ba:
        return 1
    return 0


def largest_number(ints: Sequence[int]) -> str:
    """Return the largest concatenated number formed by ordering the integers."""
    if any(value <= 0 for value in ints):
        raise ValueError("Expected positive integers")
    parts = [str(value) for value in ints]
    parts.sort(key=cmp_to_key(_compare))
    return "".join(parts)


class LargestNumberExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(largest_number((20, 3)), "320")

    def test_example_2(self) -> None:
        self.assertEqual(largest_number((3, 30, 34, 5, 9)), "9534330")


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    values = [int(token) for token in args]
    print(f"Input:  @ints = ({', '.join(args)})")
    print(f"Output: {largest_number(values)}")


if __name__ == "__main__":
    main()
