#!/usr/bin/env python3


def rank_array(integers):
    """ Given an array of integers, return an array of the ranks of each
    element: the lowest value has rank 1, next lowest rank 2, etc. If two
    elements are the same then they share the same rank.

    >>> rank_array([55, 22, 44, 33])
    (4, 1, 3, 2)
    >>> rank_array([10, 10, 10])
    (1, 1, 1)
    >>> rank_array([5, 1, 1, 4, 3])
    (4, 1, 1, 3, 2)
    """
    integers_sorted = sorted(set(integers))
    rank_dict = {}
    for n, i in enumerate(integers_sorted, start=1):
        rank_dict[i] = n
    return tuple(rank_dict[i] for i in integers)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
