#!/usr/bin/env python3

import operator
from itertools import accumulate

from more_itertools import is_prime


def binary_prefix(*binary_array):
    """ Given a binary array, return an array of booleans where the partial
    binary number up to that point is prime.

    >>> binary_prefix(1, 0, 1)
    (False, True, True)
    >>> binary_prefix(1, 1, 0)
    (False, True, False)
    >>> binary_prefix(1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 1)
    (False, True, True, False, False, True, False, False, False, False, False, \
False, False, False, False, False, False, False, False, True)
    >>> binary_prefix()
    ()
    """
    return tuple(is_prime(int(p, base=2)) for p in acc_prefix(binary_array))


def acc_prefix(binary_array):
    return accumulate(map(str, binary_array), operator.add)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
