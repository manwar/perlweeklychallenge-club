#!/usr/bin/env python
# -*- coding: utf-8 -*-

from typing import List


def search_matrix(matrix: List[List[int]], target: int) -> bool:
    if not matrix:
        return False

    rows, cols = len(matrix), len(matrix[0])
    left, right = 0, rows * cols - 1

    while left <= right:
        mid = (left + right) // 2
        mid_value = matrix[mid // cols][mid % cols]

        if mid_value == target:
            return True
        elif mid_value < target:
            left = mid + 1
        else:
            right = mid - 1

    return False


# Test cases:
matrix = [[1, 2, 3, 5, 7],
          [9, 11, 15, 19, 20],
          [23, 24, 25, 29, 31],
          [32, 33, 39, 40, 42],
          [45, 47, 48, 49, 50]]

print(search_matrix(matrix, 35))  # Output: False
print(search_matrix(matrix, 39))  # Output: True
