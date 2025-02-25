#!/usr/bin/env python3

from itertools import zip_longest, chain


def sort_odd_even(*integers):
    """ Given an array of integers, sort odd index elements in decreasing order
    and even index elements in increasing order in the given array.

    >>> sort_odd_even(4, 1, 2, 3)
    (2, 3, 4, 1)
    >>> sort_odd_even(3, 1)
    (3, 1)
    >>> sort_odd_even(5, 3, 2, 1, 4)
    (2, 3, 4, 1, 5)
    """
    return tuple(filter(None, chain.from_iterable(zip_longest(
        sorted(integers[::2]), sorted(integers[1::2], reverse=True)))))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
