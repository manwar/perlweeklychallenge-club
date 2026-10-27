#!/usr/bin/env python3
"""Contiguous Block - The Weekly Challenge 288 Task 2."""

from __future__ import annotations

from collections.abc import Sequence
import sys
import unittest


def largest_contiguous_block(matrix: list[list[str]]) -> int:
    """Find the size of the largest contiguous block in a matrix of 'x' and 'o'.

    A contiguous block consists of elements containing the same symbol which share
    an edge (not just a corner) with other elements in the block, and where there
    is a path between any two of these elements that crosses only those shared edges.

    Args:
        matrix: The input matrix of 'x' and 'o'.

    Returns:
        The size of the largest contiguous block.
    """
    if not matrix or not matrix[0]:
        return 0

    rows = len(matrix)
    cols = len(matrix[0])
    visited = [[False] * cols for _ in range(rows)]
    max_block_size = 0

    def dfs(i: int, j: int, symbol: str) -> int:
        if i < 0 or i >= rows or j < 0 or j >= cols:
            return 0
        if visited[i][j]:
            return 0
        if matrix[i][j] != symbol:
            return 0

        visited[i][j] = True
        size = 1
        # Explore neighbors (up, down, left, right)
        size += dfs(i - 1, j, symbol)
        size += dfs(i + 1, j, symbol)
        size += dfs(i, j - 1, symbol)
        size += dfs(i, j + 1, symbol)
        return size

    for i in range(rows):
        for j in range(cols):
            if not visited[i][j]:
                block_size = dfs(i, j, matrix[i][j])
                max_block_size = max(max_block_size, block_size)

    return max_block_size


class TestLargestContiguousBlock(unittest.TestCase):
    """Unit tests for largest_contiguous_block."""

    def test_example1(self) -> None:
        """Test example 1 from description."""
        matrix = [
            ["x", "x", "x", "x", "o"],
            ["x", "o", "o", "o", "o"],
            ["x", "o", "o", "o", "o"],
            ["x", "x", "x", "o", "o"],
        ]
        self.assertEqual(largest_contiguous_block(matrix), 11)

    def test_example2(self) -> None:
        """Test example 2 from description."""
        matrix = [
            ["x", "x", "x", "x", "x"],
            ["x", "o", "o", "o", "o"],
            ["x", "x", "x", "x", "o"],
            ["x", "o", "o", "o", "o"],
        ]
        self.assertEqual(largest_contiguous_block(matrix), 11)

    def test_example3(self) -> None:
        """Test example 3 from description."""
        matrix = [
            ["x", "x", "x", "o", "o"],
            ["o", "o", "o", "x", "x"],
            ["o", "x", "x", "o", "o"],
            ["o", "o", "o", "x", "x"],
        ]
        self.assertEqual(largest_contiguous_block(matrix), 7)

    def test_empty_matrix(self) -> None:
        """Test empty matrix returns 0."""
        self.assertEqual(largest_contiguous_block([]), 0)

    def test_single_element(self) -> None:
        """Test single element returns 1."""
        matrix = [["x"]]
        self.assertEqual(largest_contiguous_block(matrix), 1)


def main(argv: Sequence[str] | None = None) -> None:
    """Command-line interface."""
    unittest.main(argv=[sys.argv[0]])


if __name__ == "__main__":
    main(sys.argv)
