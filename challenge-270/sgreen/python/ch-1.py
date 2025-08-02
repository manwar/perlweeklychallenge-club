#!/usr/bin/env python3

import json
import sys


def special_positions(matrix: list) -> int:
    rows = len(matrix)
    cols = len(matrix[0])
    special_position = 0

    # Count the number of ones in each row and column
    row_count = [0] * rows
    col_count = [0] * cols

    for row in range(rows):
        # Check this has the same number of columns as the first row
        if len(matrix[row]) != cols:
            raise ValueError("Row %s has the wrong number of columns", row)

        for col in range(cols):
            if matrix[row][col]:
                row_count[row] += 1
                col_count[col] += 1

    # Find the number of special positions. This is true if the value is one
    #  and the row_count and col_count is one
    for row in range(rows):
        for col in range(cols):
            if matrix[row][col] and row_count[row] == 1 and col_count[col] == 1:
                special_position += 1

    return special_position


def main():
    matrix = json.loads(sys.argv[1])
    result = special_positions(matrix)
    print(result)


if __name__ == '__main__':
    main()
