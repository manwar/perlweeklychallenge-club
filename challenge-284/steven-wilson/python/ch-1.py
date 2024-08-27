#!/usr/bin/env python3

from collections import Counter


def lucky_integer(*integers):
    """ Given an array of integers, return the lucky integer if found otherwise
    return -1. If there are more than one then return the largest.

        A lucky integer is an integer that has a frequency in the array equal
        to its value.

    >>> lucky_integer(2, 2, 3, 4)
    2
    >>> lucky_integer(1, 2, 2, 3, 3, 3)
    3
    >>> lucky_integer(1, 1, 1, 3)
    -1
    """
    counter = Counter(integers)
    return max((i for i, v in counter.items() if i == v), default=-1)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
