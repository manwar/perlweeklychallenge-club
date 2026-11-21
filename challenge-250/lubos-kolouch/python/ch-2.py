#!/usr/bin/env python3
"""Alphanumeric String Value - Perl Weekly Challenge 250, Task 2."""

from __future__ import annotations

import unittest


def max_alphanum_value(array: list[str]) -> int:
    """Return the maximum alphanumeric value among strings in the list."""
    max_value = 0
    for s in array:
        value = int(s, 10) if s.isdigit() else len(s)
        if value > max_value:
            max_value = value
    return max_value


class TestMaxAlphanumValue(unittest.TestCase):
    """Unit tests for the max_alphanum_value function."""

    def test_examples_and_edge_cases(self) -> None:
        """Verify challenge examples and edge cases."""
        cases: list[tuple[list[str], int]] = [
            (["perl", "2", "000", "python", "r4ku"], 6),
            (["001", "1", "000", "0001"], 1),
            ([], 0),
            (["123", "456", "789"], 789),
            (["abc", "def", "ghi"], 3),
        ]
        for array, expected in cases:
            with self.subTest(array=array):
                self.assertEqual(max_alphanum_value(array), expected)


if __name__ == "__main__":
    unittest.main()
