#!/usr/bin/env python3

from collections import Counter


def unique_number(integers):
    """ Given an array of integers, where every element appears more than once
    except one element, return the one element that appears exactly one time.

    >>> unique_number([3, 3, 1])
    1
    >>> unique_number([3, 2, 4, 2, 4])
    3
    >>> unique_number([1])
    1
    >>> unique_number([4, 3, 1, 1, 1, 4])
    3
    """
    if not all(isinstance(i, int) for i in integers):
        raise ValueError('The array should only contain integers')

    counter = Counter(integers)
    unique = [k for k, v in counter.items() if v == 1]

    if len(unique) != 1:
        raise ValueError('There should be one unique element in the array')

    return unique[0]


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
