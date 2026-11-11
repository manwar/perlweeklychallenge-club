#!/usr/bin/env python3
"""Unique Occurrences - Perl Weekly Challenge 260 Task 1."""

from __future__ import annotations

from collections import Counter
import unittest


def unique_occurrences(ints: list[int]) -> int:
    """Return 1 if the number of occurrences of each value in ints is unique, else 0."""
    counts = Counter(ints).values()
    return 1 if len(counts) == len(set(counts)) else 0


class TestUniqueOccurrences(unittest.TestCase):
    """Unit tests for unique_occurrences."""

    def test_example_1(self) -> None:
        """Test Example 1: [1, 2, 2, 1, 1, 3] -> 1."""
        self.assertEqual(unique_occurrences([1, 2, 2, 1, 1, 3]), 1)

    def test_example_2(self) -> None:
        """Test Example 2: [1, 2, 3] -> 0."""
        self.assertEqual(unique_occurrences([1, 2, 3]), 0)

    def test_example_3(self) -> None:
        """Test Example 3: [-2, 0, 1, -2, 1, 1, 0, 1, -2, 9] -> 1."""
        self.assertEqual(unique_occurrences([-2, 0, 1, -2, 1, 1, 0, 1, -2, 9]), 1)


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
