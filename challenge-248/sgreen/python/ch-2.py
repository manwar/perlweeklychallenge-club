#!/usr/bin/env python3

import json
import sys


def main(matrix):
    # Calculate the size of the matrix
    rows = len(matrix)
    cols = len(matrix[0])

    # Check that all columns are of equal length
    for r in range(1, rows):
        if len(matrix[r]) != cols:
            raise ValueError(f'Row {r} has different number of columns')

    print('[')
    for r in range(rows-1):
        # Compute each row
        row = []
        for c in range(cols-1):
            row.append(matrix[r][c] + matrix[r][c+1] +
                       matrix[r+1][c] + matrix[r+1][c+1])
        print('  ' + str(row) + ',')

    print(']')


if __name__ == '__main__':
    # Read the input as JSON
    main(json.loads(sys.argv[1]))
