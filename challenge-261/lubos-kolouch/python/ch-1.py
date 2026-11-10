#!/usr/bin/env python3
"""Element Digit Sum - Perl Weekly Challenge 261 Task 1."""

from __future__ import annotations

import unittest


def element_digit_sum(ints: list[int]) -> int:
    """Return the absolute difference between the element sum and digit sum of ints."""
    element_sum = sum(ints)
    digit_sum = sum(int(c) for n in ints for c in str(abs(n)))
    return abs(element_sum - digit_sum)


class TestElementDigitSum(unittest.TestCase):
    """Unit tests for element_digit_sum."""

    def test_example_1(self) -> None:
        """Test Example 1: [1, 2, 3, 45] -> 36."""
        self.assertEqual(element_digit_sum([1, 2, 3, 45]), 36)

    def test_example_2(self) -> None:
        """Test Example 2: [1, 12, 3] -> 9."""
        self.assertEqual(element_digit_sum([1, 12, 3]), 9)

    def test_example_3(self) -> None:
        """Test Example 3: [1, 2, 3, 4] -> 0."""
        self.assertEqual(element_digit_sum([1, 2, 3, 4]), 0)

    def test_example_4(self) -> None:
        """Test Example 4: [236, 416, 336, 350] -> 1296."""
        self.assertEqual(element_digit_sum([236, 416, 336, 350]), 1296)


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
