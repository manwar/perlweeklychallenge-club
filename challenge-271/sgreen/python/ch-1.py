#!/usr/bin/env python3

import json
import sys


def maximum_ones(matrix: list) -> int:
    """
    Finds the row with the maximum number of ones in a binary matrix.

    Args:
        matrix (list): A binary matrix represented as a list of lists.

    Returns:
        int: The 1-based index of the row with the maximum number of ones.
    """

    rows = len(matrix)
    cols = len(matrix[0])

    # The row that has the maximum values
    max_row = 0

    # The number of ones in that row
    max_count = 0

    for row in range(rows):
        # Check this has the same number of columns as the first row
        if len(matrix[row]) != cols:
            raise ValueError("Row %s has the wrong number of columns", row)

        if sum(matrix[row]) > max_count:
            max_row = row
            max_count = sum(matrix[row])

    # Return the rows as a 1-based index value
    return max_row + 1


def main():
    matrix = json.loads(sys.argv[1])
    result = maximum_ones(matrix)
    print(result)


if __name__ == '__main__':
    main()
