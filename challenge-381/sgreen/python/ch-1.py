#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge"""

import json
import sys


def same_row_column(matrix: list[list[int]]) -> bool:
    """
    Find if every row and every column contains all the integers from 1 to n.

    Params:
        matrix list[list[int]]: An n × n matrix of integers

    Returns:
        bool: Whether the criteria is met
    """
    # Check that the matrix is square
    length = len(matrix)
    for row in matrix:
        if len(row) != length:
            raise ValueError("All rows must have the same length")

    # The values I expect to find
    expected_set = set(range(1, length+1))

    for i in range(length):
        # Check the row is correct
        if set(matrix[i]) != expected_set:
            return False

        # Check the column is correct
        if set(matrix[r][i] for r in range(length)) != expected_set:
            return False

    return True


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input from JSON string to a list
    matrix = json.loads(sys.argv[1])
    result = same_row_column(matrix)
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
