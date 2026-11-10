#!/usr/bin/env python3
"""Max Positive Negative - Perl Weekly Challenge 262 Task 1."""

from __future__ import annotations

import unittest


def max_positive_negative(ints: list[int]) -> int:
    """Return the maximum count of either positive or negative integers."""
    positive_count = sum(1 for x in ints if x > 0)
    negative_count = sum(1 for x in ints if x < 0)
    return max(positive_count, negative_count)


class TestMaxPositiveNegative(unittest.TestCase):
    """Unit tests for max_positive_negative."""

    def test_example_1(self) -> None:
        """Test Example 1: [-3, 1, 2, -1, 3, -2, 4] -> 4."""
        self.assertEqual(max_positive_negative([-3, 1, 2, -1, 3, -2, 4]), 4)

    def test_example_2(self) -> None:
        """Test Example 2: [-1, -2, -3, 1] -> 3."""
        self.assertEqual(max_positive_negative([-1, -2, -3, 1]), 3)

    def test_example_3(self) -> None:
        """Test Example 3: [1, 2] -> 2."""
        self.assertEqual(max_positive_negative([1, 2]), 2)

    def test_with_zeroes(self) -> None:
        """Test that zeroes are neither positive nor negative."""
        self.assertEqual(max_positive_negative([0, 0, -1, 1, 2]), 2)


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
