#!/usr/bin/env python3


def number_game(elements):
    ''' Given an array of integers, with even number of elements, create a new
    array made up of elements of the given array. Pick the two smallest
    integers and add it to new array in decreasing order i.e. high to low.
    Keep doing until the given array is empty.
    >>> number_game([2, 5, 3, 4])
    [3, 2, 5, 4]
    >>> number_game([9, 4, 1, 3, 6, 4, 6, 1])
    [1, 1, 4, 3, 6, 4, 9, 6]
    >>> number_game([1, 2, 2, 3])
    [2, 1, 3, 2]
    '''
    if not isinstance(elements, list):
        raise ValueError("Input 'elements' must be a list.")

    if len(elements) % 2 != 0:
        raise ValueError("Input 'elements' must have an even number of elements.")

    if not all(isinstance(x, int) for x in elements):
        raise ValueError("All elements in the input list must be integers.")

    elem_iter = iter(sorted(elements))
    return [item for pair in zip(elem_iter, elem_iter) for item in reversed(pair)]


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
