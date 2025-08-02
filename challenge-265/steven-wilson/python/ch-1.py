#!/usr/bin/env python3

from math import ceil
from collections import Counter


def percent_appearance(*integers, percentage=33):
    ''' Given an array of integers.  Find an integer in the given array that
    appeared for a given percentage or more. If more than one found, return the
    smallest. If none found then return undef.
    >>> percent_appearance(1,2,3,3,3,3,4,2)
    3
    >>> percent_appearance(1,1)
    1
    >>> percent_appearance(1,2,3)
    1
    '''
    if not all(isinstance(x, int) for x in integers):
        raise TypeError('All parameters should be of type integer')

    threshold = ceil((len(integers) / 100) * percentage)
    counter = Counter(integers)
    meet_threshold = (x for x, count in counter.items() if count >= threshold)
    return min(meet_threshold, default=None)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
