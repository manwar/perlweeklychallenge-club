#!/usr/bin/env python3
"""Smaller Greater Element - Perl Weekly Challenge 381 task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def smaller_greater_element(arr: list[int]) -> int:
    """Return the number of elements that have both a strictly smaller and greater element in the array."""
    if len(arr) < 3:
        return 0

    min_val = min(arr)
    max_val = max(arr)

    return sum(1 for val in arr if min_val < val < max_val)


class SmallerGreaterElementExamples(unittest.TestCase):
    def test_example_1(self) -> None:
        self.assertEqual(smaller_greater_element([2, 4]), 0)

    def test_example_2(self) -> None:
        self.assertEqual(smaller_greater_element([1, 1, 1, 1]), 0)

    def test_example_3(self) -> None:
        self.assertEqual(smaller_greater_element([1, 1, 4, 8, 12, 12]), 2)

    def test_example_4(self) -> None:
        self.assertEqual(smaller_greater_element([3, 6, 6, 9]), 2)

    def test_example_5(self) -> None:
        self.assertEqual(smaller_greater_element([0, -5, 10, -2, 4]), 3)


def main(argv: Sequence[str] | None = None) -> None:
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return
    raise SystemExit(
        "Usage: python3 ch-2.py\n(Run with no arguments to execute the unit tests)"
    )


if __name__ == "__main__":
    main()
