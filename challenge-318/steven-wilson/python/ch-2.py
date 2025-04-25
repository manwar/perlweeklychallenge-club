#!/usr/bin/env python3


def reverse_equals(source, target):
    """ Given two arrays of integers, each containing the same elements as the
    other, return true if one array can be made to equal the other by reversing
    exactly one contiguous subarray.

    >>> reverse_equals([3, 2, 1, 4], [1, 2, 3, 4])
    True
    >>> reverse_equals([1, 3, 4], [4, 1, 3])
    False
    >>> reverse_equals([2], [2])
    True
    """
    if source == target:
        return True

    (first, *middle, last) = [n for n, i in enumerate(source) if i != target[n]]
    return source[first:last+1][::-1] == target[first:last+1]


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
