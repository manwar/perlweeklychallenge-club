#!/usr/bin/env python3
"""Largest Interval - Perl Weekly Challenge 400, Task 1."""

from __future__ import annotations

import unittest


def largest_interval(limit: int) -> int:
    """Return the largest jump between consecutive unique-digit integers in 1..limit."""
    prev = 1
    max_jump = 0

    for num in range(2, limit + 1):
        s = str(num)
        if len(set(s)) == len(s):
            jump = num - prev
            if jump > max_jump:
                max_jump = jump
            prev = num

    return max_jump


class TestLargestInterval(unittest.TestCase):
    """Unit tests for the largest_interval function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[int, int]] = [
            (20, 2),
            (110, 4),
            (500, 11),
            (2026, 105),
            (10000, 105),
        ]
        for limit, expected in cases:
            with self.subTest(limit=limit):
                self.assertEqual(largest_interval(limit), expected)


if __name__ == "__main__":
    unittest.main()
