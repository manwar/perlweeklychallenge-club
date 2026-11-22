#!/usr/bin/env python3
"""Divisible Average - Perl Weekly Challenge 398, Task 1."""

from __future__ import annotations

import unittest


def divisible_average(arr: list[int]) -> int:
    """Return the closest integer to the mean of even numbers divisible by 3."""
    qualifying = [num for num in arr if num % 6 == 0]
    if not qualifying:
        return 0
    return int(sum(qualifying) / len(qualifying) + 0.5)


class TestDivisibleAverage(unittest.TestCase):
    """Unit tests for the divisible_average function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[list[int], int]] = [
            ([18, 5, 7, 11], 18),
            ([6, 12, 18, 24, 30, 40], 18),
            ([3, 9, 15, 21, 27], 0),
            ([6, 12, 14, 20], 9),
            ([6, 6, 6, 12, 12], 8),
        ]
        for arr, expected in cases:
            with self.subTest(arr=arr):
                self.assertEqual(divisible_average(arr), expected)


if __name__ == "__main__":
    unittest.main()
