import unittest
from typing import List


def largest_contiguous_block(matrix: list[list[str]]) -> int:
    """
    Finds the size of the largest contiguous block in a given matrix of 'x' and 'o'.

    A contiguous block consists of elements containing the same symbol which share
    an edge (not just a corner) with other elements in the block, and where there
    is a path between any two of these elements that crosses only those shared edges.

    Args:
        matrix (List[List[str]]): The input matrix of 'x' and 'o'.

    Returns:
        int: The size of the largest contiguous block.
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


# Unit Tests
class TestLargestContiguousBlock(unittest.TestCase):
    def test_example1(self):
        matrix = [
            ["x", "x", "x", "x", "o"],
            ["x", "o", "o", "o", "o"],
            ["x", "o", "o", "o", "o"],
            ["x", "x", "x", "o", "o"],
        ]
        self.assertEqual(largest_contiguous_block(matrix), 11, "Example 1")

    def test_example2(self):
        matrix = [
            ["x", "x", "x", "x", "x"],
            ["x", "o", "o", "o", "o"],
            ["x", "x", "x", "x", "o"],
            ["x", "o", "o", "o", "o"],
        ]
        self.assertEqual(largest_contiguous_block(matrix), 11, "Example 2")

    def test_example3(self):
        matrix = [
            ["x", "x", "x", "o", "o"],
            ["o", "o", "o", "x", "x"],
            ["o", "x", "x", "o", "o"],
            ["o", "o", "o", "x", "x"],
        ]
        self.assertEqual(largest_contiguous_block(matrix), 7, "Example 3")

    def test_empty_matrix(self):
        self.assertEqual(largest_contiguous_block([]), 0, "Empty Matrix")

    def test_single_element(self):
        matrix = [["x"]]
        self.assertEqual(largest_contiguous_block(matrix), 1, "Single Element")


if __name__ == "__main__":
    unittest.main()
