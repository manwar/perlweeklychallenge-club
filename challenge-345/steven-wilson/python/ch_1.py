#!/usr/bin/env python3


def peak_position(ints):
    """ Given an array of integers, find all the peaks in the array, a peak is
    an element that is strictly greater than its left and right neighbours.
    Return the indices of all such peak positions.
    >>> peak_position([1, 3, 2])
    [1]
    >>> peak_position([2, 4, 6, 5, 3])
    [2]
    >>> peak_position([1, 2, 3, 2, 4, 1])
    [2, 4]
    >>> peak_position([5, 3, 1])
    []
    >>> peak_position([1, 5, 1, 5, 1, 5, 1])
    [1, 3, 5]
    """
    return [n for n, i in enumerate(ints) if n > 0 and n < len(ints) - 1
            and i > ints[n-1] and i > ints[n + 1]]


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
