#!/bin/env python
"""
#===============================================================================
#
#         FILE: ch-2.py
#
#        USAGE: ./ch-2.py
#
#  DESCRIPTION: Perl Weekly Challenge #84
#               https://perlweeklychallenge.org/blog/perl-weekly-challenge-084/
#               Task 2 - Find Square
#
#       AUTHOR: Lubos Kolouch
#      CREATED: 10/30/2020 08:48:14 PM
#===============================================================================
"""


def get_square_count(matrix: list):

    # we will use the lengths so let's cache them for code readability
    m = len(matrix)
    n = len(matrix[0])

    counter = 0

    # no need to scan the last row and column
    for i in range(m):
        for j in range(n):
            # don't bother if we are at 0

            if not matrix[i][j]:
                continue

            # check the possible lengths
            # it's a square so need just the smaller distance
            for k in range(1, min(m - i, n - j)):
                # check if the corners are 1
                if matrix[i][j+k] and matrix[i+k][j] and matrix[i+k][j+k]:
                    counter += 1
    return counter


assert get_square_count([[0, 1, 0, 1], [0, 0, 1, 0], [1, 1, 0, 1], [1, 0, 0, 1]]) == 1
assert get_square_count([[1, 1, 0, 1], [1, 1, 0, 0], [0, 1, 1, 1], [1, 0, 1, 1]]) == 4
assert get_square_count([[0, 1, 0, 1], [1, 0, 1, 0], [0, 1, 0, 0], [1, 0, 0, 1]]) == 0
