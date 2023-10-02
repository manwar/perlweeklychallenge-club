#!/usr/bin/env python
# -*- coding: utf-8 -*-
def binary_matrix_score(matrix):
    # Function to flip a row or column
    def flip(arr):
        return [1 - i for i in arr]

    # Function to convert binary to decimal
    def binary_to_decimal(binary):
        return int(''.join(map(str, binary)), 2)

    # First, optimize rows, make sure the first element is 1
    for row in matrix:
        if row[0] == 0:
            row[:] = flip(row)

    # Then, optimize columns excluding the first
    cols = len(matrix[0])
    rows = len(matrix)
    for col in range(1, cols):
        if sum(matrix[row][col] for row in range(rows)) < rows / 2:
            for row in range(rows):
                matrix[row][col] = 1 - matrix[row][col]

    # Calculate score
    score = sum(binary_to_decimal(row) for row in matrix)

    return score


# Test cases:
print(binary_matrix_score(
    [[0, 0, 1, 1], [1, 0, 1, 0], [1, 1, 0, 0]]))  # Output: 39
print(binary_matrix_score([[0]]))  # Output: 1
