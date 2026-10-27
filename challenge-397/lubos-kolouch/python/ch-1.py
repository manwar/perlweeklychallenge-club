#!/usr/bin/env python3
"""Absent Smallest Positive - Perl Weekly Challenge 397 task 1."""

from __future__ import annotations

from collections.abc import Sequence
import math
import sys
import unittest


def absent_smallest_positive(arr: Sequence[int]) -> int:
    """Return smallest absent positive integer strictly greater than average of elements."""
    if not arr:
        raise ValueError("Array cannot be empty")

    avg = sum(arr) / len(arr)
    lookup = set(arr)

    # Smallest positive integer strictly greater than avg
    candidate = max(1, math.floor(avg) + 1)
    if candidate <= avg:
        candidate += 1

    while candidate in lookup:
        candidate += 1

    return candidate


class TestAbsentSmallestPositive(unittest.TestCase):
    """Unit tests for absent_smallest_positive."""

    def test_example1(self) -> None:
        """Test example 1."""
        self.assertEqual(absent_smallest_positive([1, 2, 4, 5, 6]), 7)

    def test_example2(self) -> None:
        """Test example 2."""
        self.assertEqual(absent_smallest_positive([-5, -2, -1, 3]), 1)

    def test_example3(self) -> None:
        """Test example 3."""
        self.assertEqual(absent_smallest_positive([1, 2, 3]), 4)

    def test_example4(self) -> None:
        """Test example 4."""
        self.assertEqual(absent_smallest_positive([2, 3, 7, 8]), 6)

    def test_example5(self) -> None:
        """Test example 5."""
        self.assertEqual(absent_smallest_positive([1, 1, 1, 10]), 4)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        arr = [int(x) for x in argv[1:]]
        print(f"Output: {absent_smallest_positive(arr)}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
