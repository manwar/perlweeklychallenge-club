#!/usr/bin/env python3

from itertools import combinations


def friendly_strings(a, b):
    """ Given two strings, return true if swapping any two letters in one
    string match the other string, return false otherwise.

    >>> friendly_strings("desc", "dsec")
    True
    >>> friendly_strings("fuck", "fcuk")
    True
    >>> friendly_strings("poo", "eop")
    False
    >>> friendly_strings("stripe", "sprite")
    True
    """
    swaps = combinations(range(len(a)), 2)
    return any(a[:x] + a[y] + a[x+1:y] + a[x] + a[y+1:] == b for x, y in swaps)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
