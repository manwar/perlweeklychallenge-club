#!/usr/bin/env python3


def arrange_binary(bits, number):
    """ Given a list of binary digits (0 and 1) and a positive integer, $n,
    return true if you can re-arrange the list by replacing at least $n digits
    with 1 in the given list so that no two consecutive digits are 1 otherwise
    return false

    >>> arrange_binary([1, 0, 0, 0, 1], 1)
    True
    >>> arrange_binary([1, 0, 0, 0, 1], 2)
    False
    >>> arrange_binary([0], 1)
    True
    >>> arrange_binary([1], 1)
    False
    >>> arrange_binary([], 1)
    False
    """
    len_b = len(bits)
    possible_ones = len_b // 2 if len_b % 2 == 0 else len_b // 2 + 1
    actual_ones = sum(1 for bit in bits if bit == 1)
    return actual_ones + number <= possible_ones


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
