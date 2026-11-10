#!/usr/bin/env python3
"""Multiply by Two - Perl Weekly Challenge 261 Task 2."""

from __future__ import annotations

import unittest


def multiply_by_two(ints: list[int], start: int) -> int:
    """Repeatedly multiply start by 2 while it is present in ints."""
    ints_set = set(ints)

    while start in ints_set:
        start *= 2

    return start


class TestMultiplyByTwo(unittest.TestCase):
    """Unit tests for multiply_by_two."""

    def test_example_1(self) -> None:
        """Test Example 1: [5, 3, 6, 1, 12], start=3 -> 24."""
        self.assertEqual(multiply_by_two([5, 3, 6, 1, 12], 3), 24)

    def test_example_2(self) -> None:
        """Test Example 2: [1, 2, 4, 3], start=1 -> 8."""
        self.assertEqual(multiply_by_two([1, 2, 4, 3], 1), 8)

    def test_example_3(self) -> None:
        """Test Example 3: [5, 6, 7], start=2 -> 2."""
        self.assertEqual(multiply_by_two([5, 6, 7], 2), 2)


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
