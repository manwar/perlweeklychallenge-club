#!/usr/bin/env python3

from collections import Counter


def special_position(matrix):
    ''' Given a m x n binary matrix, return the number of special positions in
    the given binary matrix.

        A position (i, j) is called special if $matrix[i][j] == 1 and all other
        elements in the row i and column j are 0.

    >>> special_position([[1, 0, 0], [0, 0, 1], [1, 0, 0],])
    1
    >>> special_position([ [1, 0, 0], [0, 1, 0], [0, 0, 1], ])
    3
    '''
    possible = [row.index(1) for row in matrix if sum(row) == 1]
    counter = Counter(possible)
    return sum(1 for value in counter.values() if value == 1)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
