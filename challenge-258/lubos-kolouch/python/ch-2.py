#!/usr/bin/env python3
"""Sum of Values - Perl Weekly Challenge 258 Task 2."""

from __future__ import annotations

import unittest


def sum_of_values(ints: list[int], k: int) -> int:
    """Calculate the sum of values whose indices have exactly k 1-bits.

    Args:
        ints: A list of integers.
        k: Required number of 1-bits in the binary representation of the index.

    Returns:
        The sum of values at matching indices.
    """
    return sum(value for i, value in enumerate(ints) if bin(i).count("1") == k)


class TestSumOfValues(unittest.TestCase):
    """Unit tests for sum_of_values."""

    def test_example_1(self) -> None:
        """Test Example 1: k = 1."""
        self.assertEqual(sum_of_values([2, 5, 9, 11, 3], 1), 17)

    def test_example_2(self) -> None:
        """Test Example 2: k = 2."""
        self.assertEqual(sum_of_values([2, 5, 9, 11, 3], 2), 11)

    def test_example_3(self) -> None:
        """Test Example 3: k = 0."""
        self.assertEqual(sum_of_values([2, 5, 9, 11, 3], 0), 2)


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
