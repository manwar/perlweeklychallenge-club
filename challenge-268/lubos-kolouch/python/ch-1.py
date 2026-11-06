#!/usr/bin/env python3
"""Magic Number - The Weekly Challenge 268 Task 1."""

from __future__ import annotations

import sys
import unittest


def find_magic_number(x: list[int], y: list[int]) -> int:
    """Find the magic number that transforms array x into array y when added.

    Args:
        x: The first list of integers.
        y: The second list of integers.

    Returns:
        The magic number added to each element of x to yield y.

    Raises:
        ValueError: If lists are empty, have different sizes, or no magic number exists.
    """
    if len(x) != len(y):
        raise ValueError("Input arrays must be of the same size")
    if not x or not y:
        raise ValueError("Input arrays must not be empty")

    sorted_x = sorted(x)
    sorted_y = sorted(y)

    diff = sorted_y[0] - sorted_x[0]
    for xi, yi in zip(sorted_x, sorted_y):
        if yi - xi != diff:
            raise ValueError("No magic number found")

    return diff


class TestMagicNumber(unittest.TestCase):
    """Unit tests for find_magic_number."""

    def test_example_1(self) -> None:
        """Test Example 1: x = [3, 7, 5], y = [9, 5, 7] -> 2."""
        self.assertEqual(find_magic_number([3, 7, 5], [9, 5, 7]), 2)

    def test_example_2(self) -> None:
        """Test Example 2: x = [1, 2, 1], y = [5, 4, 4] -> 3."""
        self.assertEqual(find_magic_number([1, 2, 1], [5, 4, 4]), 3)

    def test_example_3(self) -> None:
        """Test Example 3: x = [2], y = [5] -> 3."""
        self.assertEqual(find_magic_number([2], [5]), 3)

    def test_different_size(self) -> None:
        """Test ValueError when lists have different sizes."""
        with self.assertRaises(ValueError):
            find_magic_number([1, 2, 3], [4, 5])

    def test_empty_arrays(self) -> None:
        """Test ValueError when lists are empty."""
        with self.assertRaises(ValueError):
            find_magic_number([], [])

    def test_no_magic_number(self) -> None:
        """Test ValueError when no single magic number works."""
        with self.assertRaises(ValueError):
            find_magic_number([1, 2, 3], [10, 20, 30])


def main() -> None:
    """Run unit tests."""
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main()
