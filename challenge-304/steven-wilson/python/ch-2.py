#!/usr/bin/env python3

from more_itertools import sliding_window
from statistics import mean


def maximum_average(integers, number):
    """ Given an array of integers, @ints and an integer, $n which is less than
    or equal to total elements in the given array, find the contiguous subarray
    whose length is the given integer, $n, and has the maximum average. It
    should return the average.

    >>> maximum_average([1, 12, -5, -6, 50, 3], 4)
    12.75
    >>> maximum_average([5], 1)
    5
    """
    return max(mean(subarray) for subarray in sliding_window(integers, number))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
