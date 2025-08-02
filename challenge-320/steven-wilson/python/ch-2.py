#!/usr/bin/env python3


def sum_difference(integers):
    """ Given an array of positive integers, return the absolute difference
    between digit sum and element sum of the given array.

    >>> sum_difference([1, 23, 4, 5])
    18
    >>> sum_difference([1, 2, 3, 4, 5])
    0
    >>> sum_difference([1, 2, 34])
    27
    """
    element_sum = sum(integers)
    digit_sum = sum(int(i) for i in "".join(map(str, integers)))
    return abs(digit_sum - element_sum)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
