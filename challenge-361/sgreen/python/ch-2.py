#!/usr/bin/env python3

import json
import sys


def find_celebrity(matrix: list[list[int]]) -> int:
    """
    Find the celebrity from a matrix, or -1 when none found.

    A celebrity is someone, everyone knows and knows nobody.

    Params:
        matrix list[list[int]]: A matrix
    """

    # Check that the matrix is square
    row_length = len(matrix)
    for row in matrix:
        if len(row) != row_length:
            raise ValueError("All rows must have the same length")

    for row_idx, row in enumerate(matrix):
        if sum(row):
            # This celebrity knows someone
            continue

        # Check if everyone else know this celebrity.
        is_celebrity = all(
            col_idx == row_idx or matrix[col_idx][row_idx]
            for col_idx in range(row_length)
        )
        if is_celebrity:
            # We have the celebrity
            return row_idx

    # No celebrity is found
    return -1


def main():
    # Convert input into matrix of integers
    matrix = json.loads(sys.argv[1])
    result = find_celebrity(matrix)
    print(result)


if __name__ == "__main__":
    main()
