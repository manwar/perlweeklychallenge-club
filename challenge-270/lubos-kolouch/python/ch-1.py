#!/usr/bin/env python3
"""Special Positions in a Binary Matrix - Perl Weekly Challenge 270 Task 1."""

from __future__ import annotations

import unittest


def num_special_positions(matrix: list[list[int]]) -> int:
    """Return the number of special positions in a binary matrix.

    A position (i, j) is special if matrix[i][j] == 1 and all other elements in row i
    and column j are 0.
    """
    if not matrix or not matrix[0]:
        return 0

    rows = len(matrix)
    cols = len(matrix[0])

    row_sums = [sum(row) for row in matrix]
    col_sums = [sum(matrix[r][c] for r in range(rows)) for c in range(cols)]

    special_count = 0
    for r in range(rows):
        if row_sums[r] != 1:
            continue
        for c in range(cols):
            if matrix[r][c] == 1 and col_sums[c] == 1:
                special_count += 1

    return special_count


class TestSpecialPositions(unittest.TestCase):
    """Unit tests for num_special_positions."""

    def test_example1(self) -> None:
        """Test example 1 from challenge description."""
        matrix = [[1, 0, 0], [0, 0, 1], [1, 0, 0]]
        self.assertEqual(num_special_positions(matrix), 1)

    def test_example2(self) -> None:
        """Test example 2 from challenge description."""
        matrix = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]
        self.assertEqual(num_special_positions(matrix), 3)

    def test_non_square(self) -> None:
        """Test non-square matrix."""
        matrix = [[0, 0, 0, 1], [1, 0, 0, 0], [0, 1, 0, 0]]
        self.assertEqual(num_special_positions(matrix), 3)

    def test_all_zeros(self) -> None:
        """Test matrix with no 1s."""
        matrix = [[0, 0], [0, 0]]
        self.assertEqual(num_special_positions(matrix), 0)


def main() -> None:
    """Run unit tests."""
    unittest.main()


if __name__ == "__main__":
    main()
