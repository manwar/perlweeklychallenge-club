#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def is_toeplitz(matrix: List[List[int]]) -> bool:
    """
    Check if the given matrix is a Toeplitz Matrix.

    A matrix is Toeplitz if every diagonal from top-left to bottom-right has the same elements.

    :param matrix: A list of lists containing integers.
    :return: True if the matrix is Toeplitz, False otherwise.
    """
    rows = len(matrix)
    cols = len(matrix[0])

    for i in range(rows - 1):
        for j in range(cols - 1):
            if matrix[i][j] != matrix[i + 1][j + 1]:
                return False

    return True


# Test cases
matrix1 = [
    [4, 3, 2, 1],
    [5, 4, 3, 2],
    [6, 5, 4, 3],
]

matrix2 = [
    [1, 2, 3],
    [3, 2, 1],
]

# Tests
assert is_toeplitz(matrix1) == True
assert is_toeplitz(matrix2) == False

print("All tests passed!")
