#!/usr/bin/env python3

import sys


def twod_array(ints: list, rows: int, cols: int) -> list[list[int]]:
    """
    Convert a flat list of integers into a 2D array with specified rows and columns.
    :param ints: List of integers to convert.
    :param rows: Number of rows in the 2D array.
    :param cols: Number of columns in the 2D array.
    :return: 2D array represented as a list of lists.
    """
    if rows < 1 or cols < 1:
        raise ValueError("Rows and columns must be greater than 0.")
    if rows * cols != len(ints):
        raise ValueError(
            "The product of rows and columns must equal the length of the input list.")

    return [[ints[i * cols + j] for j in range(cols)] for i in range(rows)]


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    *ints, rows, cols = array
    result = twod_array(ints, rows, cols)
    print(result)


if __name__ == '__main__':
    main()
