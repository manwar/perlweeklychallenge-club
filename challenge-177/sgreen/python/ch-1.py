#!/usr/bin/env python3

import sys


def main(num):
    check_table = [
        [0, 3, 1, 7, 5, 9, 8, 6, 4, 2],
        [7, 0, 9, 2, 1, 5, 4, 8, 6, 3],
        [4, 2, 0, 6, 8, 7, 1, 3, 5, 9],
        [1, 7, 5, 0, 9, 8, 3, 4, 2, 6],
        [6, 1, 2, 3, 0, 4, 5, 9, 7, 8],
        [3, 6, 7, 4, 2, 0, 9, 5, 8, 1],
        [5, 8, 6, 9, 7, 2, 0, 1, 3, 4],
        [8, 9, 4, 5, 3, 6, 2, 0, 1, 7],
        [9, 4, 3, 8, 6, 1, 7, 2, 0, 5],
        [2, 5, 8, 1, 4, 3, 6, 7, 9, 0],
    ]

    # Start with the first row
    row_idx = 0

    # Work through each digit
    for col_idx in num:
        # Change the row to the vaule of the digit in the current row
        row_idx = check_table[row_idx][int(col_idx)]

    # Print 1 if the check sum is valid (row_idx = 0), other wise 0.
    print(1 if row_idx == 0 else 0)


if __name__ == '__main__':
    main(sys.argv[1])
