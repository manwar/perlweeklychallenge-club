#!/usr/bin/env python3

import json
import sys


def validate_matrix(matrix):
    # Calculate the size of the matrix
    rows = len(matrix)
    cols = len(matrix[0])

    for r in range(1, rows):
        # Check that all columns are of equal length
        if len(matrix[r]) != cols:
            raise ValueError(f'Row {r} has different number of columns')


def echelon(matrix: list) -> int:
    # Check that the matrix is valid
    validate_matrix(matrix)

    # Get the position of the first one in each row
    leading_one = [None if 1 not in row else row.index(1) for row in matrix]

    for row_num in range(len(matrix)):
        row = matrix[row_num]
        leading_one_pos = leading_one[row_num]

        # If the row is all zeros, there is nothing to check
        if all(value == 0 for value in row):
            continue

        # Check the first non zero number is one
        for value in row:
            if value == 1:
                break
            if value != 0:
                return 0

        # Check if the leading one is further right
        if row_num != 0:
            if leading_one[row_num - 1] is None:
                # The previous row was all zeros.
                return 0
            if leading_one[row_num - 1] > leading_one_pos:
                # The previous first one was further to the right
                return 0

        # Count the number of non-zero values in the column that is the
        #  leading one. It should be one (this row)
        if sum(1 for row in matrix if row[leading_one_pos] != 0) != 1:
            return 0

    return 1


def main():
    # Convert input into a list of list of integers
    matrix = json.loads(sys.argv[1])
    result = echelon(matrix)
    print(result)


if __name__ == '__main__':
    main()
