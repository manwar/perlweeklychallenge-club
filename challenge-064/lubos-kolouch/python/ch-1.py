#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def min_sum_path(matrix: List[List[int]]) -> int:
    rows = len(matrix)
    columns = len(matrix[0])

    for i in range(1, rows):
        matrix[i][0] += matrix[i - 1][0]

    for j in range(1, columns):
        matrix[0][j] += matrix[0][j - 1]

    for i in range(1, rows):
        for j in range(1, columns):
            matrix[i][j] += min(matrix[i - 1][j], matrix[i][j - 1])

    return matrix[-1][-1]


matrix = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

print(f"Minimum sum path: {min_sum_path(matrix)}")  # Output: 21
