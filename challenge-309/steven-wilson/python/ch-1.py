#!/usr/bin/env python3


def min_gap(*integers):
    """ Given an array of integers, in increasing order, return the element
    before which you find the smallest gap.

    >>> min_gap(2, 8, 10, 11, 15)
    11
    >>> min_gap(1, 5, 6, 7, 14)
    6
    >>> min_gap(8, 20, 25, 28)
    28
    """
    return min((integers[n+1] - i, integers[n+1])
               for n, i in enumerate(integers[:-1]))[1]


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
