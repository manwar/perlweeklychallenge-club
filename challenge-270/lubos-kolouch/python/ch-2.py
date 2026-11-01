#!/usr/bin/env python3
"""Equalize Array - Perl Weekly Challenge 270 Task 2."""

from __future__ import annotations

import unittest


def min_cost_to_equal_elements(ints: list[int], x: int, y: int) -> int:
    """Return the minimum cost to make all elements in ints equal.

    Level 1: Increase any element by 1 with cost x.
    Level 2: Increase any two different elements by 1 with cost y.
    """
    n = len(ints)
    if n <= 1:
        return 0
    if n == 2:
        return abs(ints[0] - ints[1]) * x

    max_val = max(ints)
    min_val = min(ints)

    if 2 * x <= y:
        return sum(max_val - num for num in ints) * x

    best = float("inf")
    limit = max_val + (max_val - min_val) + 2

    for target in range(max_val, limit + 1):
        total_diff = sum(target - num for num in ints)
        max_diff = target - min_val

        if 2 * max_diff <= total_diff:
            pairs = total_diff // 2
            singles = total_diff % 2
        else:
            pairs = total_diff - max_diff
            singles = total_diff - 2 * pairs

        cost = pairs * y + singles * x
        if cost < best:
            best = cost

    return int(best)


class TestEqualizeArray(unittest.TestCase):
    """Unit tests for min_cost_to_equal_elements."""

    def test_example1(self) -> None:
        """Test example 1 from challenge description."""
        self.assertEqual(min_cost_to_equal_elements([4, 1], 3, 2), 9)

    def test_example2(self) -> None:
        """Test example 2 from challenge description."""
        self.assertEqual(min_cost_to_equal_elements([2, 3, 3, 3, 5], 2, 1), 6)

    def test_target_higher_than_max(self) -> None:
        """Test case where optimal target is strictly greater than max element."""
        self.assertEqual(min_cost_to_equal_elements([1, 2, 2], 3, 1), 2)

    def test_already_equal(self) -> None:
        """Test case where array is already equalized."""
        self.assertEqual(min_cost_to_equal_elements([5, 5, 5], 2, 1), 0)

    def test_expensive_level2(self) -> None:
        """Test case where Level 2 is more expensive than 2 * Level 1."""
        self.assertEqual(min_cost_to_equal_elements([1, 1, 5], 2, 10), 16)


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
