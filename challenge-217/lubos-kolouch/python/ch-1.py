#!/usr/bin/env python
# -*- coding: utf-8 -*-

def third_smallest(matrix):
    flattened = [elem for sublist in matrix for elem in sublist]
    flattened.sort()
    return flattened[2]


matrix1 = [[3, 1, 2], [5, 2, 4], [0, 1, 3]]
matrix2 = [[2, 1], [4, 5]]
matrix3 = [[1, 0, 3], [0, 0, 0], [1, 2, 1]]

print(third_smallest(matrix1))
print(third_smallest(matrix2))
print(third_smallest(matrix3))
