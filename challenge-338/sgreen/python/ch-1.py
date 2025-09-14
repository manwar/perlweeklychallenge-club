#!/usr/bin/env python3

import json
import sys


def highest_row(matrix: list[list[int]]) -> int:
    """Return the highest sum of any row in the matrix.

    Args:
        matrix: A list of lists of integers.

    Returns:
        The highest sum of any row in the matrix.
    """
    return max(sum(row) for row in matrix)


def main():
    # Convert input into a matrix
    matrix = json.loads(sys.argv[1])
    result = highest_row(matrix)
    print(result)


if __name__ == '__main__':
    main()
