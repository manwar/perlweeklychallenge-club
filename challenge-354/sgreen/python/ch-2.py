#!/usr/bin/env python3

import json
import sys


def shift_grid(matrix: list[list[int]], k: int) -> list[list[int]]:
    # Check that all rows are the same length
    row_length = len(matrix[0])
    for row in matrix:
        if len(row) != row_length:
            raise ValueError("All rows must have the same length")

    # Flatten the matrix
    flattened_list = [num for row in matrix for num in row]

    # Make sure k is between 0 and the one less than the length
    k = k % len(flattened_list)

    # Move the last k elements to the front
    rotated_list = flattened_list[-k:] + flattened_list[:-k]

    # Rebuild the matrix
    new_matrix = []
    for i in range(0, len(rotated_list), row_length):
        new_matrix.append(rotated_list[i:i + row_length])

    return new_matrix


def main():
    matrix = json.loads(sys.argv[1])
    k = int(sys.argv[2])
    result = shift_grid(matrix, k)
    print("(" + ",\n ".join(str(row) for row in result) + ",)")


if __name__ == "__main__":
    main()
