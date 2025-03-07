#!/usr/bin/env python3

from more_itertools import sliding_window, flatten


def odd_sum(*integers):
    """ Given an array of positive integers, return the sum of all possible
    odd-length subarrays of the given array. A subarray is a contiguous
    subsequence of the array.

    >>> odd_sum(2, 5, 3, 6, 4)
    77
    >>> odd_sum(1, 3)
    4
    """
    odd_lengths = range(1, len(integers) + 1, 2)
    subarrays = (sa for ol in odd_lengths for sa in sliding_window(integers, ol))
    return sum(i for i in flatten(subarrays))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
