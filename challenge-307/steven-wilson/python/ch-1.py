#!/usr/bin/env python3


def check_order(integers):
    """ Given an array of integers, re-arrange the given array in an increasing
    order and return the indices where it differs from the original array.

    >>> check_order((5, 2, 4, 3, 1))
    (0, 2, 3, 4)
    >>> check_order((1, 2, 1, 1, 3))
    (1, 3)
    >>> check_order((3, 1, 3, 2, 3))
    (0, 1, 3)
    """
    return tuple(n for n, i in enumerate(sorted(integers)) if i != integers[n])


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
