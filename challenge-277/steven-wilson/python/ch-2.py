#!/usr/bin/env python3

from itertools import combinations


def strong_pair(*integers):
    """ Given an array of integers, return the count of all strong pairs in the
    given array.

        A pair of integers x and y is called strong pair if it satisfies:
        0 < |x - y| < min(x, y).

    >>> strong_pair(1, 2, 3, 4, 5)
    4
    >>> strong_pair(5, 7, 1, 7)
    1
    """
    return len({(x, y) for x, y in combinations(integers, 2)
        if 0 < abs(x - y) and abs(x - y) < min(x, y)})


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
