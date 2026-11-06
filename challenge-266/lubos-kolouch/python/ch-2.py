#!/usr/bin/env python3
"""X Matrix - The Weekly Challenge 266 Task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def is_x_matrix(matrix: list[list[int]]) -> bool:
    """Determine whether a given square matrix is an X Matrix.

    A square matrix is an X Matrix if all the elements in the diagonals
    of the matrix are non-zero and all other elements are 0.

    Args:
        matrix: A square 2D list of integers.

    Returns:
        True if the matrix is an X Matrix, False otherwise.
    """
    n = len(matrix)
    for i in range(n):
        for j in range(n):
            if i == j or i + j == n - 1:
                if matrix[i][j] == 0:
                    return False
            else:
                if matrix[i][j] != 0:
                    return False
    return True


class TestIsXMatrix(unittest.TestCase):
    """Unit tests for is_x_matrix."""

    def test_example1(self) -> None:
        """Test Example 1: 4x4 valid X Matrix."""
        matrix = [
            [1, 0, 0, 2],
            [0, 3, 4, 0],
            [0, 5, 6, 0],
            [7, 0, 0, 1],
        ]
        self.assertTrue(is_x_matrix(matrix))

    def test_example2(self) -> None:
        """Test Example 2: 3x3 non-X Matrix."""
        matrix = [
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9],
        ]
        self.assertFalse(is_x_matrix(matrix))

    def test_example3(self) -> None:
        """Test Example 3: 3x3 valid X Matrix."""
        matrix = [
            [1, 0, 2],
            [0, 3, 0],
            [4, 0, 5],
        ]
        self.assertTrue(is_x_matrix(matrix))

    def test_zero_on_diagonal(self) -> None:
        """Test matrix with a zero on the diagonal."""
        matrix = [
            [1, 0, 2],
            [0, 0, 0],
            [4, 0, 5],
        ]
        self.assertFalse(is_x_matrix(matrix))

    def test_single_element(self) -> None:
        """Test 1x1 matrix."""
        self.assertTrue(is_x_matrix([[5]]))
        self.assertFalse(is_x_matrix([[0]]))


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
