#!/usr/bin/env python3

from collections import Counter
from itertools import chain


def relative_sort(list1, list2):
    """ Given two list of integers, the elements in the list2 are distinct and
    also in the list1.

    Sort the elements in the list1 such that the relative order of items in
    list1 is same as in the list2. Elements that is missing in list2 should be
    placed at the end of list1 in ascending order.

    >>> relative_sort([2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6])
    [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9]
    >>> relative_sort([3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2])
    [1, 3, 3, 3, 2, 2, 4, 4, 6]
    >>> relative_sort([3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2])
    [1, 1, 1, 0, 0, 3, 2, 4, 5]
    """
    counter = Counter()
    not_in_2 = []
    for i in list1:
        if i in list2:
            counter[i] += 1
        else:
            not_in_2.append(i)

    return list(chain.from_iterable([i] * counter[i] for i in list2)) + sorted(not_in_2)


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
