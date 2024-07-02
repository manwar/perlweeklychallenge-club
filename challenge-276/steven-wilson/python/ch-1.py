#!/usr/bin/env python3

from itertools import combinations


def complete_day(*hours):
    ''' Given an array of integers (hours),return the number of pairs that
    forms a complete day.

        A complete day is defined as a time duration that is an exact multiple
        of 24 hours.

    >>> complete_day(12, 12, 30, 24, 24)
    2
    >>> complete_day(72, 48, 24, 5)
    3
    >>> complete_day(12, 18, 24)
    0
    '''
    return sum(1 for pair in combinations(hours, 2) if sum(pair) % 24 == 0)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
