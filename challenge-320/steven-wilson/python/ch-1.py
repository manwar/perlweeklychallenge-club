#!/usr/bin/env python3


def maximum_count(integers):
    """ Given an array of integers, return the maximum between the number of
    positive and negative integers. Zero is neither positive nor negative.

    >>> maximum_count([-3, -2, -1, 1, 2, 3])
    3
    >>> maximum_count([-2, -1, 0, 0, 1])
    2
    >>> maximum_count([1, 2, 3, 4])
    4
    """
    (positive, negative) = (0, 0)
    for i in integers:
        if i > 0:
            positive += 1
        elif i < 0:
            negative += 1
    return max(positive, negative)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
