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

    # Calculate the column maximums
    column_max = []
    for c in range(cols):
        column_max.append(max(map(lambda i: i[c], matrix)))

    solution = -1

    # Go through each row
    for r in matrix:
        # Get the value of all columns that are the minimum value for this row
        #  and the maximum for the column
        row_min = min(r)
        if any(True for i, value in enumerate(r)
               if value == row_min and column_max[i] == value):
            # We have a lucky number (row_min)
            solution = row_min
            break

    print(solution)


if __name__ == '__main__':
    # Read the input as JSON
    main(json.loads(sys.argv[1]))
