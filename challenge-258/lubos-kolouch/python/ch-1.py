#!/usr/bin/env python3
"""Count Even Digits Number - Perl Weekly Challenge 258 Task 1."""

from __future__ import annotations

import unittest


def count_even_digits(ints: list[int] | tuple[int, ...]) -> int:
    """Count integers in the sequence that have an even number of digits.

    Args:
        ints: A list or tuple of positive integers.

    Returns:
        The count of integers with an even number of digits.
    """
    return sum(1 for num in ints if len(str(abs(num))) % 2 == 0)


class TestCountEvenDigits(unittest.TestCase):
    """Unit tests for count_even_digits."""

    def test_example_1(self) -> None:
        """Test Example 1: (10, 1, 111, 24, 1000)."""
        self.assertEqual(count_even_digits((10, 1, 111, 24, 1000)), 3)

    def test_example_2(self) -> None:
        """Test Example 2: (111, 1, 11111)."""
        self.assertEqual(count_even_digits((111, 1, 11111)), 0)

    def test_example_3(self) -> None:
        """Test Example 3: (2, 8, 1024, 256)."""
        self.assertEqual(count_even_digits([2, 8, 1024, 256]), 1)


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
