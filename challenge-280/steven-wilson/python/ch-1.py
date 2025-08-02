#!/usr/bin/env python3

from collections import Counter
from string import ascii_lowercase


def twice_appearance(string):
    """ Given a string containing lowercase English letters only, return the
    first letter that appears twice.

    >>> twice_appearance("acbddbca")
    'd'
    >>> twice_appearance("abccd")
    'c'
    >>> twice_appearance("abcdabbb")
    'a'
    >>> twice_appearance("abcdefgh")

    """
    if any(c not in ascii_lowercase for c in string):
        raise ValueError("String should contain only lowercase letters")

    counter = Counter()
    for c in string:
        counter[c] += 1
        if counter[c] == 2:
            return c
    return None


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
