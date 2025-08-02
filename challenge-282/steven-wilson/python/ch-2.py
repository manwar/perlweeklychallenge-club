#!/usr/bin/env python3

from itertools import groupby


def changing_keys(string):
    """ Given an alphabetic string as typed by user,return the number of times
    user had to change the key to type the given string. Changing key is
    defined as using a key different from the last used key. The shift and caps
    lock keys won’t be counted.
    >>> changing_keys('pPeERrLl')
    3
    >>> changing_keys('rRr')
    0
    >>> changing_keys('GoO')
    1
    """
    if len(string) == 0:
        return 0

    if not all(c.isalpha() for c in string):
        raise ValueError('User should type an aphabetic string')

    return sum(1 for _ in groupby(string.casefold())) - 1


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
