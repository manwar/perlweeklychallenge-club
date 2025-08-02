#!/usr/bin/env python3

from operator import itemgetter


def maximum_ones(matrix):
    ''' Given a m x n binary matrix, return the row number containing maximum
    ones, in case of more than one rows then return smallest row number.
    >>> maximum_ones([ [0, 1],[1, 0],])
    1
    >>> maximum_ones([ [0, 0, 0],[1, 0, 1],])
    2
    >>> maximum_ones([ [0, 0],[1, 1],[0, 0],])
    2
    '''
    row_sum = ((n, sum(row)) for n, row in enumerate(matrix, start=1))
    return sorted(row_sum, key=itemgetter(1), reverse=True)[0][0]


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
