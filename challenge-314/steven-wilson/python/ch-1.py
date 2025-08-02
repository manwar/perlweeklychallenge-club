#!/usr/bin/env python3
from itertools import takewhile


def equal_strings(*strings):
    """ Given three strings.  You are allowed to remove the rightmost character
    of a string to make all equals, return the number of operations to make it
    equal otherwise -1.

    >>> equal_strings("abc", "abb", "ab")
    2
    >>> equal_strings("ayz", "cyz", "xyz")
    -1
    >>> equal_strings("yza", "yzb", "yzc")
    3
    """
    count = sum(1 for _ in takewhile(lambda z: len(set(z)) == 1, zip(*strings)))
    return sum(len(s) - count for s in strings) if count else -1


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
