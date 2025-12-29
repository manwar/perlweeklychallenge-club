#!/usr/bin/env python3
"""Minimum Common - Perl Weekly Challenge 319 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def minimum_common(array_1: Sequence[int], array_2: Sequence[int]) -> int:
    """Return the smallest integer appearing in both arrays, or -1 if none."""
    common = set(array_1).intersection(array_2)
    return min(common) if common else -1


class MinimumCommonExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(minimum_common((1, 2, 3, 4), (3, 4, 5, 6)), 3)

    def test_example_2(self) -> None:
        self.assertEqual(minimum_common((1, 2, 3), (2, 4)), 2)

    def test_example_3(self) -> None:
        self.assertEqual(minimum_common((1, 2, 3, 4), (5, 6, 7, 8)), -1)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    if len(args) != 2:
        raise SystemExit(
            "Usage: python3 ch-2.py <comma-separated-array1> <comma-separated-array2>"
        )

    array_1 = [int(value) for value in args[0].split(",") if value]
    array_2 = [int(value) for value in args[1].split(",") if value]
    result = minimum_common(array_1, array_2)
    print(f"Input: @array_1 = ({', '.join(map(str, array_1))})")
    print(f"       @array_2 = ({', '.join(map(str, array_2))})")
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
