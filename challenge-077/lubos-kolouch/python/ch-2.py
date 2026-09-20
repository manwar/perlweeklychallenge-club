#!/usr/bin/env python3
"""Perl Weekly Challenge 077 - Task 2: Lonely X.

Count the total number of 'X' surrounded by 'O' only in an m x n matrix.
"""

from __future__ import annotations

import unittest


def is_cell_lonely(matrix: list[list[str]], r: int, c: int) -> bool:
    """Check if cell at (r, c) has no adjacent 'X' in all 8 directions.

    :param matrix: 2D list of 'O' and 'X'.
    :param r: Row index.
    :param c: Column index.
    :return: True if strictly surrounded by 'O' (or matrix boundaries), False otherwise.
    """
    rows = len(matrix)
    cols = len(matrix[0])

    for dr in (-1, 0, 1):
        for dc in (-1, 0, 1):
            if dr == 0 and dc == 0:
                continue
            nr, nc = r + dr, c + dc
            if 0 <= nr < rows and 0 <= nc < cols:
                if matrix[nr][nc] == "X":
                    return False

    return True


def count_lonely_x(matrix: list[list[str]]) -> int:
    """Count the total number of 'X' surrounded only by 'O' in an m x n matrix.

    :param matrix: 2D list of characters 'O' and 'X'.
    :return: Total count of lonely 'X' cells.
    """
    if not matrix or not matrix[0]:
        return 0

    rows = len(matrix)
    cols = len(matrix[0])
    count = 0

    for r in range(rows):
        for c in range(cols):
            if matrix[r][c] == "X" and is_cell_lonely(matrix, r, c):
                count += 1

    return count


class TestLonelyX(unittest.TestCase):
    """Test cases for count_lonely_x."""

    def test_example_1(self) -> None:
        matrix = [
            ["O", "O", "X"],
            ["X", "O", "O"],
            ["X", "O", "O"],
        ]
        self.assertEqual(count_lonely_x(matrix), 1)

    def test_example_2(self) -> None:
        matrix = [
            ["O", "O", "X", "O"],
            ["X", "O", "O", "O"],
            ["X", "O", "O", "X"],
            ["O", "X", "O", "O"],
        ]
        self.assertEqual(count_lonely_x(matrix), 2)

    def test_no_lonely(self) -> None:
        matrix = [
            ["X", "X"],
            ["X", "X"],
        ]
        self.assertEqual(count_lonely_x(matrix), 0)


if __name__ == "__main__":
    unittest.main()
