#!/usr/bin/env python3


def minimum_common(one, two):
    """ Given two arrays of integers, return the minimum integer common to both
    arrays. If none found return -1.
    >>> minimum_common((1, 2, 3, 4), (3, 4, 5, 6))
    3
    >>> minimum_common((1, 2, 3), (2, 4))
    2
    >>> minimum_common((1, 2, 3, 4), (5, 6, 7, 8))
    -1
    """
    try:
        return min(set(one).intersection(two))
    except ValueError:
        return -1


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
