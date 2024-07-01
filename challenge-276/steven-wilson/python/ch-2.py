#!/usr/bin/env python3

from collections import Counter


def maximum_frequency(*integers):
    ''' Given an array of positive integers, return the total number of
    elements in the given array which have the highest frequency.

    >>> maximum_frequency(1, 2, 2, 4, 1, 5)
    4
    >>> maximum_frequency(1, 2, 3, 4, 5)
    5
    '''
    counter = Counter(integers)
    frequency = list(zip(*counter.most_common()))[1]
    return sum(value for value in frequency if value == frequency[0])


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
