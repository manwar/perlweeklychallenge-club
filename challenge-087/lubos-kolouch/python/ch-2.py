#!/bin/env python
"""
#===============================================================================
#
#         FILE: ch-2.py
#
#        USAGE: ./ch-2.py
#
#  DESCRIPTION: Perl Weekly Challenge 088
#               Task 2 - Largest Rectangle
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 11/22/2020 04:34:38 PM
#===============================================================================
"""


def get_rectangle(input_arr):
    """ Get the largest rectangle """
    max_x = max_y = 0

    # loop through the array
    # look if the current element is 1
    # if so, check how far can go in the row and columns
    # if the rectangle is largest, save the dimensions

    for r, row in enumerate(input_arr[:-1]):
        for c, item in enumerate(row[:-1]):

            if item:
                # print(f"* 1 at {r} {c}")
                size1 = size2 = 0

                while (r+size1 < len(input_arr)) and (input_arr[r+size1][c]):
                    # print(f" v 1 at {r} {c}")

                    # scan through the column and see what is the min size
                    y_shift = 0

                    while (c+y_shift < len(row)) and (input_arr[r+size1][c+y_shift]):
                        # print(f"  > 1 at {r+size1} {c+y_shift}")
                        y_shift += 1

                    size2 = min(size2, y_shift) if size2 else y_shift

                    if size2 == 1:
                        break

                    size1 += 1

                if size1 * size2 > max_x * max_y:
                    max_x = size1
                    max_y = size2

    # print and return the results
    if not max_x * max_y > 1:
        print("0")
        return 0

    for _ in range(max_x):
        row_str = "[ "

        for _ in range(max_y):
            row_str += "1 "

        row_str += "]"
        print(row_str)

    return (max_x, max_y)


assert get_rectangle([[0, 0, 0, 1, 0, 0], [1, 1, 1, 0, 0, 0], [0, 0, 1, 0, 0, 1],
                     [1, 1, 1, 1, 1, 0], [1, 1, 1, 1, 1, 0]]) == (2, 5)
assert get_rectangle([[1, 0, 1, 0, 1, 0], [0, 1, 0, 1, 0, 1], [1, 0, 1, 0, 1, 0],
                     [0, 1, 0, 1, 0, 1]]) == 0
assert get_rectangle([[0, 0, 0, 1, 1, 1], [1, 1, 1, 1, 1, 1], [0, 0, 1, 0, 0, 1],
                      [0, 0, 1, 1, 1, 1], [0, 0, 1, 1, 1, 1]]) == (2, 4)
