#!/usr/bin/env python3


def max_positive_negative(*elements):
    '''
    Given an array of integers, return the maximum number of either positive or
    negative integers in the given array.
    >>> max_positive_negative(-3, 1, 2, -1, 3, -2, 4)
    4
    >>> max_positive_negative(-1, -2, -3, 1)
    3
    >>> max_positive_negative(1,2)
    2
    '''
    if not all(isinstance(elem, int) for elem in elements):
        raise TypeError("Arguments must be integers")

    positive = sum(1 for elem in elements if elem >= 0)
    negative = len(elements) - positive

    return max(positive, negative)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
