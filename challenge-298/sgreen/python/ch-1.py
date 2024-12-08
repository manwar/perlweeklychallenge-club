#!/usr/bin/env python3

import json
import sys


def find_square_from_point(matrix, x: int, y: int, max_side: int) -> int:
    """Find the largest square at a particular point

    Args:
        matrix: The matrix
        x (int): The starting row
        y (int): The starting column
        max_side (int): The maximum side of a side before going out of bounds

    Returns:
        int: The area of the square
    """
    side = 1
    for s in range(1, max_side):
        all_ones = True
        for i in range(s+1):
            if matrix[x+i][y+s] == 0 or matrix[x+s][y+i] == 0:
                all_ones = False
                break

        if not all_ones:
            break

        side += 1

    return side ** 2


def maximal_square(matrix: list[list[int]]) -> int:
    """Find the largest square of ones in a matrix

    Args:
        matrix: A matrix of zeros and ones

    Returns:
        int: The largest square found
    """

    rows = len(matrix)
    cols = len(matrix[0])
    maximum_size = 0

    # Check each row has the same number of columns as the first row
    for row in range(rows):
        if len(matrix[row]) != cols:
            raise ValueError("Row %s has the wrong number of columns", row)

    for row in range(rows):
        for col in range(cols):
            if matrix[row][col] == 1:
                # Calculate the shortest side before going out of bounds
                max_side = min(rows-row, cols-col)

                # Find the largest square from this point (top left)
                size = find_square_from_point(matrix, row, col, max_side)
                if size > maximum_size:
                    maximum_size = size

    return maximum_size


def main():
    matrix = json.loads(sys.argv[1])
    result = maximal_square(matrix)
    print(result)


if __name__ == '__main__':
    main()
