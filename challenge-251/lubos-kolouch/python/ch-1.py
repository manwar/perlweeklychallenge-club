#!/usr/bin/env python3
"""Concatenation Value - Perl Weekly Challenge 251, Task 1."""

from __future__ import annotations

import unittest


def concatenation_value(ints: list[int]) -> int:
    """Return the concatenation value of the given list of integers."""
    concat_value = 0
    left = 0
    right = len(ints) - 1

    while left < right:
        concat_value += int(f"{ints[left]}{ints[right]}")
        left += 1
        right -= 1

    if left == right:
        concat_value += ints[left]

    return concat_value


class TestConcatenationValue(unittest.TestCase):
    """Unit tests for the concatenation_value function."""

    def test_examples(self) -> None:
        """Verify all challenge examples and edge cases."""
        cases: list[tuple[list[int], int]] = [
            ([6, 12, 25, 1], 1286),
            ([10, 7, 31, 5, 2, 2], 489),
            ([1, 2, 10], 112),
            ([42], 42),
            ([], 0),
        ]
        for ints, expected in cases:
            with self.subTest(ints=ints):
                self.assertEqual(concatenation_value(ints), expected)


if __name__ == "__main__":
    unittest.main()
