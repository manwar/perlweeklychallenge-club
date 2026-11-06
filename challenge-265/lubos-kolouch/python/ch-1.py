#!/usr/bin/env python3
"""33% Appearance - Perl Weekly Challenge 265 Task 1."""

from __future__ import annotations

from collections import Counter
import unittest


def find_integer_appearing_33_percent_or_more(ints: list[int]) -> int | None:
    """Find an integer that appears 33% or more of the time in the given list.

    If multiple integers satisfy the condition, the smallest integer is returned.
    If no such integer exists or the input list is empty, None is returned.
    """
    if not ints:
        return None

    counts = Counter(ints)
    n = len(ints)

    valid_numbers = [num for num, cnt in counts.items() if (cnt / n) >= 0.33]

    return min(valid_numbers) if valid_numbers else None


class Test33PercentAppearance(unittest.TestCase):
    """Unit tests for find_integer_appearing_33_percent_or_more."""

    def test_example_1(self) -> None:
        """Test Example 1: 3 appears 4/8 = 50% (> 33%)."""
        self.assertEqual(
            find_integer_appearing_33_percent_or_more([1, 2, 3, 3, 3, 3, 4, 2]),
            3,
        )

    def test_example_2(self) -> None:
        """Test Example 2: 1 appears 2/2 = 100% (> 33%)."""
        self.assertEqual(find_integer_appearing_33_percent_or_more([1, 1]), 1)

    def test_example_3(self) -> None:
        """Test Example 3: all appear 1/3 = 33.33%, smallest is 1."""
        self.assertEqual(find_integer_appearing_33_percent_or_more([1, 2, 3]), 1)

    def test_empty_list(self) -> None:
        """Test empty input list returns None."""
        self.assertIsNone(find_integer_appearing_33_percent_or_more([]))

    def test_no_qualification(self) -> None:
        """Test list where no element reaches 33%."""
        self.assertIsNone(find_integer_appearing_33_percent_or_more([1, 2, 3, 4]))

    def test_multiple_qualifying_picks_smallest(self) -> None:
        """Test list with tie where multiple reach 33% threshold, picks smallest."""
        self.assertEqual(find_integer_appearing_33_percent_or_more([5, 5, 2, 2]), 2)


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
