#!/usr/bin/env python3


def bitwise_or_trailing_zeros(*integers):
    ''' Given an array of positive integers, find out if it is possible to
    select two or more elements of the given array such that the bitwise OR of
    the selected elements has at least one trailing zero in its binary
    representation.
    >>> bitwise_or_trailing_zeros(1, 2, 3, 4, 5)
    True
    >>> bitwise_or_trailing_zeros(2, 3, 8, 16)
    True
    >>> bitwise_or_trailing_zeros(1, 2, 5, 7, 9)
    False
    '''
    return sum(1 for i in integers if i % 2 == 0) >= 2


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
