#!/usr/bin/env python3

from collections import Counter


def frequencySort(elements):
    """Return count of similar words. Two words are similar if they
    consist of the same characters.
    >>> frequencySort([1, 1, 2, 2, 2, 3])
    [3, 1, 1, 2, 2, 2]
    >>> frequencySort([2, 3, 1, 3, 2])
    [1, 3, 3, 2, 2]
    >>> frequencySort([-1, 1, -6, 4, 5, -6, 1, 4, 1])
    [5, -1, 4, 4, -6, -6, 1, 1, 1]
    """
    elemCount = Counter(elements)
    return sorted(elements, key=lambda x: (elemCount[x], -x))


if __name__ == "__main__":
    import doctest

    doctest.testmod()
