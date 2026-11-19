#!/usr/bin/env python3
"""Special Numbers - Perl Weekly Challenge 252 Task 1."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def sum_of_special_squares(ints: Sequence[int]) -> int:
    """Return the sum of squares of all special elements in ints.

    An element at 1-based index ``i`` is special if ``i`` divides ``len(ints)``.
    """
    n = len(ints)
    return sum(ints[i - 1] ** 2 for i in range(1, n + 1) if n % i == 0)


class TestSumOfSpecialSquares(unittest.TestCase):
    """Unit tests for sum_of_special_squares."""

    def test_example_1(self) -> None:
        """Test Example 1."""
        self.assertEqual(sum_of_special_squares([1, 2, 3, 4]), 21)

    def test_example_2(self) -> None:
        """Test Example 2."""
        self.assertEqual(sum_of_special_squares([2, 7, 1, 19, 18, 3]), 63)

    def test_single_element(self) -> None:
        """Test single-element list."""
        self.assertEqual(sum_of_special_squares([5]), 25)

    def test_empty_list(self) -> None:
        """Test empty list."""
        self.assertEqual(sum_of_special_squares([]), 0)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    if argv and len(argv) > 1:
        ints = [int(x) for x in argv[1:]]
        print(f"Output: {sum_of_special_squares(ints)}")
        return
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
