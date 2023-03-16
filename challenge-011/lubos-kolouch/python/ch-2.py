#!/usr/bin/env python
# -*- coding: utf-8 -*-

size = 4  # change this to the desired size
identity_matrix = [[0 for x in range(size)] for y in range(size)]

for i in range(size):
    identity_matrix[i][i] = 1

# print the identity matrix
for row in identity_matrix:
    print(row)
