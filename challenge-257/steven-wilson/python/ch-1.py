#!/usr/bin/env python3


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
    >>> smaller_than_current(1, 0, 0, 0, 1, 2)
    (3, 0, 0, 0, 3, 5)
    >>> smaller_than_current()
    ()
    '''
    # Counting algorithm
    if not integers:
        return ()

    min_i = min(integers)
    max_i = max(integers)
    count = [0] * (max_i - min_i + 1)
    for i in integers:
        count[i - min_i] += 1

    for pos in range(1, max_i - min_i):
        count[pos] += count[pos-1]

    return tuple(count[i - min_i - 1] if i != min_i else 0 for i in integers)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
