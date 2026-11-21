#!/usr/bin/env python3
"""Lucky Numbers - Perl Weekly Challenge 251, Task 2."""

from __future__ import annotations

import unittest


def lucky_number(matrix: list[list[int]]) -> int:
    """Return the lucky number in matrix, or -1 if none exists.

    A lucky number is an element that is the minimum in its row
    and the maximum in its column.
    """
    for row in matrix:
        if not row:
            continue
        min_row = min(row)
        min_index = row.index(min_row)
        if all(other_row[min_index] <= min_row for other_row in matrix):
            return min_row
    return -1


class TestLuckyNumber(unittest.TestCase):
    """Unit tests for the lucky_number function."""

    def test_examples(self) -> None:
        """Verify all challenge examples and edge cases."""
        cases: list[tuple[list[list[int]], int]] = [
            ([[3, 7, 8], [9, 11, 13], [15, 16, 17]], 15),
            ([[1, 10, 4, 2], [9, 3, 8, 7], [15, 16, 17, 12]], 12),
            ([[7, 8], [1, 2]], 7),
            ([[3, 1], [2, 4]], -1),
        ]
        for matrix, expected in cases:
            with self.subTest(matrix=matrix):
                self.assertEqual(lucky_number(matrix), expected)


if __name__ == "__main__":
    unittest.main()
