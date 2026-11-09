#!/usr/bin/env python3
"""Count Equal Divisible - Perl Weekly Challenge 262 Task 2."""

from __future__ import annotations

import unittest


def count_equal_divisible(ints: list[int], k: int) -> int:
    """Count pairs (i, j) with 0 <= i < j < len(ints), ints[i] == ints[j], and (i * j) % k == 0."""
    count = 0
    n = len(ints)
    for i in range(n):
        for j in range(i + 1, n):
            if ints[i] == ints[j] and (i * j) % k == 0:
                count += 1
    return count


class TestCountEqualDivisible(unittest.TestCase):
    """Unit tests for count_equal_divisible."""

    def test_example_1(self) -> None:
        """Test Example 1: [3, 1, 2, 2, 2, 1, 3], k=2 -> 4."""
        self.assertEqual(count_equal_divisible([3, 1, 2, 2, 2, 1, 3], 2), 4)

    def test_example_2(self) -> None:
        """Test Example 2: [1, 2, 3], k=1 -> 0."""
        self.assertEqual(count_equal_divisible([1, 2, 3], 1), 0)

    def test_empty_list(self) -> None:
        """Test empty list returns 0."""
        self.assertEqual(count_equal_divisible([], 2), 0)


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
