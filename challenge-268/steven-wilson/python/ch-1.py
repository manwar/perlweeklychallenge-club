#!/usr/bin/env python3


def magic_number(x, y):
    ''' Given two arrays of integers of same size, find the magic number that
    when added to each elements of one of the array gives the second array.
    Elements order is not important.
    >>> magic_number([3, 7, 5], [9, 5, 7])
    2
    >>> magic_number([1, 2, 1], [5, 4, 4])
    3
    >>> magic_number([2], [5])
    3
    '''
    if not isinstance(x, list) or not isinstance(y, list):
        raise ValueError("Inputs 'x' and 'y' must be lists.")

    if len(x) != len(y):
        raise ValueError("Inputs 'x' and 'y' must have the same length.")

    if not all(isinstance(num, int) for num in x) or not all(isinstance(num, int) for num in y):
        raise ValueError("All elements in 'x' and 'y' must be integers.")

    return abs(max(x) - max(y))


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
