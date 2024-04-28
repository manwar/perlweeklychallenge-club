#!/usr/bin/env python3

import json
import sys


def x_matrix(matrix: list) -> bool:
    """Determine if the matrix is a X Matrix

    Args:
        matrix (list): The supplied matrix

    Returns:
        bool: Wether the matrix as a X Matrix or not
    """
    rows = len(matrix)

    # Check we have a square
    for row in range(rows):
        if len(matrix[row]) != rows:
            raise ValueError("Please specify a square matrix")

    # Check that all the values are correct
    for row in range(rows):
        for col in range(rows):
            if col == row or col == rows - 1 - row:
                # We are expecting a non-zero value
                if matrix[row][col] == 0:
                    return False
            elif matrix[row][col] != 0:
                # We are expecting a zero value
                return False

    return True


def main():
    # Parse the matrix from the input
    matrix = json.loads(sys.argv[1])
    result = x_matrix(matrix)
    print('true' if result else 'false')


if __name__ == '__main__':
    main()
