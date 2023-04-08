#!/usr/bin/env python3

import json
import sys


def main(matrix):
    # Let's define some variables
    rows = len(matrix)
    cols = len(matrix[0])

    # We always check from the top left
    offsets = [[0, 0]]

    # If the matrix isn't square, we also use an offset to hit the bottom right
    if rows > cols:
        offsets.append([rows-cols, 0])
    elif rows < cols:
        offsets.append([0, cols-rows])

    # The number of checks we need to make
    counts = min(rows, cols)

    for o in offsets:
        # Define the offsets, and the first value
        row_offset, col_offset = o
        value = matrix[row_offset][col_offset]

        for i in range(1, counts):
            # Compare the value until we find one that doesn't match
            if value != matrix[row_offset+i][col_offset+i]:
                print('false')
                return

    # Print results
    print('true')


if __name__ == '__main__':
    main(json.loads(sys.argv[1]))
