#!/usr/bin/env python3

import json
import sys


def validate_matrix(matrix):
    # Calculate the size of the matrix
    rows = len(matrix)
    cols = len(matrix[0])

    for r in range(0, rows):
        # Check that all columns are of equal length
        if len(matrix[r]) != cols:
            raise ValueError(f'Row {r} has different number of columns')

        # Check all values are 0 or 1
        if any(True for i in matrix[r] if i not in (0, 1)):
            raise ValueError(f'Row {r} has a value other than 0 or 1')

        # Check there are no ones zeros after zero.
        if any(True for c in range(1, cols) if matrix[r][c-1] == 0 and matrix[r][c] == 1):
            raise ValueError(f'Row {r} has a 1 after 0')


def weakest_row(matrix):
    # Start by validating any issues with the input
    validate_matrix(matrix)

    # Sort by the rows with the most 1s, followed by a numerical sort
    return sorted(range(len(matrix)), key=lambda i: sum(matrix[i]))


def main(json_string):
    matrix = json.loads(json_string)
    result = weakest_row(matrix)
    print('(' + ', '.join(map(str, result)) + ')')


if __name__ == '__main__':
    main(sys.argv[1])
