#!/usr/bin/env python3
"""Weakest Row - Perl Weekly Challenge 253, Task 2."""

from __future__ import annotations

import unittest


def weakest_row(matrix: list[list[int]]) -> list[int]:
    """Return row indices sorted from weakest to strongest."""
    row_strength: list[tuple[int, int]] = [
        (sum(row), index) for index, row in enumerate(matrix)
    ]
    row_strength.sort()
    return [index for _, index in row_strength]


class TestWeakestRow(unittest.TestCase):
    """Unit tests for the weakest_row function."""

    def test_examples(self) -> None:
        """Verify all challenge examples."""
        cases: list[tuple[list[list[int]], list[int]]] = [
            (
                [
                    [1, 1, 0, 0, 0],
                    [1, 1, 1, 1, 0],
                    [1, 0, 0, 0, 0],
                    [1, 1, 0, 0, 0],
                    [1, 1, 1, 1, 1],
                ],
                [2, 0, 3, 1, 4],
            ),
            (
                [
                    [1, 0, 0, 0],
                    [1, 1, 1, 1],
                    [1, 0, 0, 0],
                    [1, 0, 0, 0],
                ],
                [0, 2, 3, 1],
            ),
        ]
        for matrix, expected in cases:
            with self.subTest(matrix=matrix):
                self.assertEqual(weakest_row(matrix), expected)


if __name__ == "__main__":
    unittest.main()
