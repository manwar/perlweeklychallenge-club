#!/usr/bin/env python3
"""Distinct Average - Perl Weekly Challenge 321 task 1."""

from __future__ import annotations

from collections.abc import Sequence
from fractions import Fraction
import sys
import unittest


def distinct_average_count(nums: Sequence[Fraction]) -> int:
    """
    Return the count of distinct averages while repeatedly removing min and max.

    The task states that the input length is even.
    """
    if len(nums) % 2 != 0:
        raise ValueError("Expected an even-length list")

    sorted_nums = sorted(nums)
    seen: set[Fraction] = set()

    left = 0
    right = len(sorted_nums) - 1
    while left < right:
        seen.add((sorted_nums[left] + sorted_nums[right]) / 2)
        left += 1
        right -= 1

    return len(seen)


class DistinctAverageExamples(unittest.TestCase):
    """Example-based tests from the specification."""

    def test_example_1(self) -> None:
        self.assertEqual(distinct_average_count([Fraction(x) for x in (1, 2, 4, 3, 5, 6)]), 1)

    def test_example_2(self) -> None:
        self.assertEqual(distinct_average_count([Fraction(x) for x in (0, 2, 4, 8, 3, 5)]), 2)

    def test_example_3(self) -> None:
        self.assertEqual(distinct_average_count([Fraction(x) for x in (7, 3, 1, 0, 5, 9)]), 2)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    args = list(sys.argv[1:] if argv is None else argv)
    if not args:
        unittest.main(argv=[sys.argv[0]])
        return

    values = [Fraction(token) for token in args]
    result = distinct_average_count(values)
    print(f"Input:  @nums = ({', '.join(args)})")
    print(f"Output: {result}")


if __name__ == "__main__":
    main()
