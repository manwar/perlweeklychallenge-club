#!/usr/bin/env python3
"""Bitwise OR with Trailing Zero - Perl Weekly Challenge 269 Task 1."""

from __future__ import annotations

import unittest


def bitwise_or_with_trailing_zero(ints: list[int]) -> bool:
    """Determine if two or more elements can be selected with a bitwise OR having a trailing zero.

    A bitwise OR of two or more numbers has at least one trailing zero if and only if
    the result is even. For the bitwise OR to be even, every chosen number must be even.
    Hence, such a subset of size >= 2 exists if and only if the list contains at least
    two even numbers.
    """
    even_count = 0
    for num in ints:
        if num % 2 == 0:
            even_count += 1
            if even_count >= 2:
                return True
    return False


class TestBitwiseOrWithTrailingZero(unittest.TestCase):
    """Unit tests for bitwise_or_with_trailing_zero."""

    def test_example_1(self) -> None:
        """Test Example 1 from challenge description."""
        self.assertTrue(bitwise_or_with_trailing_zero([1, 2, 3, 4, 5]))

    def test_example_2(self) -> None:
        """Test Example 2 from challenge description."""
        self.assertTrue(bitwise_or_with_trailing_zero([2, 3, 8, 16]))

    def test_example_3(self) -> None:
        """Test Example 3 from challenge description."""
        self.assertFalse(bitwise_or_with_trailing_zero([1, 2, 5, 7, 9]))

    def test_no_trailing_zero(self) -> None:
        """Test list with all odd numbers."""
        self.assertFalse(bitwise_or_with_trailing_zero([1, 3, 5, 7, 9]))

    def test_all_even(self) -> None:
        """Test list with all even numbers."""
        self.assertTrue(bitwise_or_with_trailing_zero([2, 4, 6, 8, 10]))

    def test_minimal_two_evens(self) -> None:
        """Test list with exactly two even numbers."""
        self.assertTrue(bitwise_or_with_trailing_zero([4, 6]))

    def test_minimal_one_even(self) -> None:
        """Test list with one even and one odd number."""
        self.assertFalse(bitwise_or_with_trailing_zero([3, 4]))


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
