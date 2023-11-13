#!/usr/bin/env python3

from itertools import permutations


def reverse_pairs(*elements):
    '''
    return the number of reverse pairs in the given array
    >>> reverse_pairs(1, 3, 2, 3, 1)
    2
    >>> reverse_pairs(2, 4, 3, 5, 1)
    3
    '''
    count = 0
    perms = permutations(range(len(elements)), r=2)
    for i, j in perms:
        if elements[i] > 2 * elements[j] and 0 <= i and i < j and j < len(elements):
            count += 1
    return count


if __name__ == "__main__":
    import doctest

    doctest.testmod()
