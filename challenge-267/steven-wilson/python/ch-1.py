#!/usr/bin/env python3

from math import prod


def product_sign(*integers):
    ''' Given an array, find the sign of product of all integers in the given
    array. The sign is 1 if the product is positive, -1 if the product is
    negative and 0 if product is zero.
    >>> product_sign(-1, -2, -3, -4, 3, 2, 1)
    1
    >>> product_sign(1, 2, 0, -2, -1)
    0
    >>> product_sign(-1, -1, 1, -1, 2)
    -1
    '''
    if not integers or not all(isinstance(x, int) for x in integers):
        raise TypeError('All paramaters should be of type int')

    product = prod(integers)
    return 1 if product > 0 else -1 if product < 0 else 0


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
