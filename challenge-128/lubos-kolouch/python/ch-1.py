#!/usr/bin/env python
# -*- coding: utf-8 -*-
def max_submatrix(matrix):
    max_area = 0
    max_i = max_j = max_width = max_height = 0

    for i, row in enumerate(matrix):
        for j, cell in enumerate(row):
            if cell != 0:
                continue

            width = 1
            height = 1

            while i + height < len(matrix) and matrix[i + height][j] == 0:
                height += 1

            while j + width < len(row) and all_zeros(matrix, i, j, height, width):
                width += 1

            area = width * height

            if area > max_area:
                max_area = area
                max_i, max_j, max_width, max_height = i, j, width, height

    return [
        row[max_j : max_j + max_width] for row in matrix[max_i : max_i + max_height]
    ]


def all_zeros(matrix, i, j, height, width):
    return all(matrix[k][j + width] == 0 for k in range(i, i + height))


matrix = [
    [1, 0, 0, 0, 1, 0],
    [1, 1, 0, 0, 0, 1],
    [1, 0, 0, 0, 0, 0],
]

result = max_submatrix(matrix)
for row in result:
    print(" ".join(str(x) for x in row))
