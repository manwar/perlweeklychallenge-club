#!/usr/bin/env python3

from collections import Counter


def smaller_than_current(*integers):
    ''' Given an array of integers, find out how many integers are smaller than
    current i.e. foreach ints[i], count ints[j] < ints[i] where i != j
    >>> smaller_than_current(5, 2, 1, 6)
    (2, 1, 0, 3)
    >>> smaller_than_current(1, 2, 0, 3)
    (1, 2, 0, 3)
    >>> smaller_than_current(0, 1)
    (0, 1)
    >>> smaller_than_current(9, 4, 9, 2)
    (2, 1, 2, 0)
    '''
    integer_counter = Counter(integers)
    results = []
    for i in integers:
        results.append(sum(count for key, count in integer_counter.items()
                           if key < i))
    return tuple(results)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
