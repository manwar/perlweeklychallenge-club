#!/usr/bin/env python3

import json
import sys
from operator import xor


def main(matrix):
    solution = 0
    cols = len(matrix[0])
    xor_row = 2 ** cols - 1

    # Convert the matrix into a row of integers
    matrix = [int(''.join(str(b) for b in x), 2) for x in matrix]

    for col_xor in range(2 ** cols):
        xor_matrix = [xor(x, col_xor) for x in matrix]
        total = sum([max(xor_row - x, x) for x in xor_matrix])
        if total > solution:
            solution = total

    print(solution)


if __name__ == '__main__':
    main(json.loads(sys.argv[1]))
