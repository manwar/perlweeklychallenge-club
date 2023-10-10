#!/usr/bin/env python3

from itertools import permutations


def calculate_greatness(elements, permutation):
    ''' Calculate greatness of array of integers and a permutation
    >>> calculate_greatness([1, 3, 5, 2, 1, 3, 1], [2, 5, 1, 3, 3, 1, 1])
    4
    >>> calculate_greatness([1, 2, 3, 4], [2, 3, 4, 1])
    3
    >>> calculate_greatness([1, 2], [1, 2])
    0
    '''
    count = 0
    for index, elem in enumerate(elements):
        if elem < permutation[index]:
            count += 1
    return count


def maximise_greatness(elements):
    ''' return maximum possible greatness from permutations of an array of integers
    >>> maximise_greatness([1, 3, 5, 2, 1, 3, 1])
    4
    >>> maximise_greatness([1, 2, 3, 4])
    3
    >>> maximise_greatness([1, 1, 1])
    0
    '''
    perms = set(permutations(elements))
    max_greatness = 0
    for permutation in perms:
        greatness = calculate_greatness(elements, permutation)
        if greatness > max_greatness:
            max_greatness = greatness
    return max_greatness


if __name__ == "__main__":
    import doctest

    doctest.testmod()
