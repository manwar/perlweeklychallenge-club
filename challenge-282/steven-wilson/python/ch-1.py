#!/usr/bin/env python3

from itertools import groupby


def good_integer(integer):
    """ Given a positive integer, having 3 or more digits, return the Good
    Integer in the given integer or -1 if none found.

        A good integer is exactly three consecutive matching digits.

    >>> good_integer(12344456)
    '444'
    >>> good_integer(1233334)
    -1
    >>> good_integer(10020003)
    '000'
    """
    integer_string = str(integer)

    if len(integer_string) < 3:
        raise ValueError('Integer provided must have at least 3 digits')

    for _, item in groupby(integer_string):
        group = ''.join(item)
        if len(group) == 3:
            return group
    return -1


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
