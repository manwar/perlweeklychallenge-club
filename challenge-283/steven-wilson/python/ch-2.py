#!/usr/bin/env python3

from collections import Counter


def digit_count_value(integers):
    """ Given an array of positive integers, return true if for every index i
    in the range 0 <= i < size of array, the digit i occurs exactly the ints[i]
    times in the given array otherwise return false.

    >>> digit_count_value([1, 2, 1, 0])
    True
    >>> digit_count_value([0, 3, 0])
    False
    """
    if not all(isinstance(i, int) for i in integers):
        raise ValueError("Array values should be integers")

    if not all(i >= 0 for i in integers):
        raise ValueError("Array values should be positive")

    counter = Counter(integers)
    for n, i in enumerate(integers):
        if i != counter[n]:
            return False
    return True


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
