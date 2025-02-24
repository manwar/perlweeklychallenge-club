#!/usr/bin/env python3

from itertools import combinations


def min_diff(*integers):
    """ Given an array of integers, find the minimum difference between any two
    elements.

    >>> min_diff(1, 5, 8, 9)
    1
    >>> min_diff(9, 4, 1, 7)
    2
    """
    return min(abs(c[0] - c[1]) for c in combinations(integers, 2))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
