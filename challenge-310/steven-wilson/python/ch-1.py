#!/usr/bin/env python3

from collections import Counter


def arrays_intersection(*arrays):
    """ Given a list of array of integers, return the common elements in all
    the arrays.

    >>> arrays_intersection( [1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3] )
    (1, 4)
    >>> arrays_intersection( [1, 0, 2, 3], [2, 4, 5] )
    (2,)
    >>> arrays_intersection( [1, 2, 3], [4, 5], [6] )
    ()
    """
    len_arrays = len(arrays)
    counter = Counter(i for array in arrays for i in set(array))
    return tuple(sorted(i for i in counter.keys() if counter[i] == len_arrays))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
