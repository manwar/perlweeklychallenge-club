#!/usr/bin/env python
# -*- coding: utf-8 -*-

def zero_matrix(matrix):
    m = len(matrix)
    n = len(matrix[0])
    zero_rows = set()
    zero_cols = set()

    # Identify rows and columns that should be zeroed out
    for i in range(m):
        for j in range(n):
            if matrix[i][j] == 0:
                zero_rows.add(i)
                zero_cols.add(j)

    # Zero out identified rows and columns
    for i in range(m):
        for j in range(n):
            if i in zero_rows or j in zero_cols:
                matrix[i][j] = 0

    return matrix


matrix1 = [[1, 0, 1], [1, 1, 1], [1, 1, 1]]
matrix2 = [[1, 0, 1], [1, 1, 1], [1, 0, 1]]
print(zero_matrix(matrix1))
print(zero_matrix(matrix2))
