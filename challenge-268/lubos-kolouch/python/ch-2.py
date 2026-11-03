#!/usr/bin/env python3
"""Number Game - The Weekly Challenge 268 Task 2."""

from __future__ import annotations

import sys
import unittest


def number_game(ints: list[int]) -> list[int]:
    """Play the number game by picking pairs of smallest integers.

    Repeatedly picks the two smallest integers from the input list
    and appends them to the result in decreasing order (high to low).

    Args:
        ints: A list of integers with an even number of elements.

    Returns:
        The resulting list of integers.

    Raises:
        ValueError: If the input list contains an odd number of elements.
    """
    if len(ints) % 2 != 0:
        raise ValueError("Input list must contain an even number of elements")

    sorted_ints = sorted(ints)
    result: list[int] = []

    for i in range(0, len(sorted_ints), 2):
        result.extend([sorted_ints[i + 1], sorted_ints[i]])

    return result


class TestNumberGame(unittest.TestCase):
    """Unit tests for number_game."""

    def test_example_1(self) -> None:
        """Test Example 1: [2, 5, 3, 4] -> [3, 2, 5, 4]."""
        self.assertEqual(number_game([2, 5, 3, 4]), [3, 2, 5, 4])

    def test_example_2(self) -> None:
        """Test Example 2: [9, 4, 1, 3, 6, 4, 6, 1] -> [1, 1, 4, 3, 6, 4, 9, 6]."""
        self.assertEqual(
            number_game([9, 4, 1, 3, 6, 4, 6, 1]), [1, 1, 4, 3, 6, 4, 9, 6]
        )

    def test_example_3(self) -> None:
        """Test Example 3: [1, 2, 2, 3] -> [2, 1, 3, 2]."""
        self.assertEqual(number_game([1, 2, 2, 3]), [2, 1, 3, 2])

    def test_already_sorted(self) -> None:
        """Test input that is already sorted."""
        self.assertEqual(number_game([1, 2, 3, 4, 5, 6]), [2, 1, 4, 3, 6, 5])

    def test_reverse_sorted(self) -> None:
        """Test input that is reverse sorted."""
        self.assertEqual(number_game([6, 5, 4, 3, 2, 1]), [2, 1, 4, 3, 6, 5])

    def test_duplicate_elements(self) -> None:
        """Test input with duplicate elements."""
        self.assertEqual(number_game([5, 1, 5, 1, 2, 2]), [1, 1, 2, 2, 5, 5])

    def test_odd_length(self) -> None:
        """Test ValueError when input has odd length."""
        with self.assertRaises(ValueError):
            number_game([1, 2, 3])


def main() -> None:
    """Run unit tests."""
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main()
