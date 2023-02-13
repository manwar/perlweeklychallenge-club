#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
from typing import List, Union


def reshape(matrix: List[List[int]], r: int,
            c: int) -> Union[int, List[List[int]]]:
    m, n = np.shape(matrix)
    if m * n != r * c:
        return 0
    flat_matrix = np.array(matrix).flatten()
    reshaped_matrix = np.reshape(flat_matrix, (r, c))
    return reshaped_matrix.tolist()


matrix = [[1, 2], [3, 4]]
r = 1
c = 4
result = reshape(matrix, r, c)

if result == 0:
    print("Cannot reshape matrix")
else:
    print("Reshaped matrix:")
    for row in result:
        print(row)
