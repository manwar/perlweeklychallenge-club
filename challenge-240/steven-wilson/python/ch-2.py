#!/usr/bin/env python3


def build_array(elements):
    '''
    create an array such that new[i] = old[old[i]] where 0 <= i < new.length
    >>> build_array([0, 2, 1, 5, 3, 4])
    [0, 1, 2, 4, 5, 3]
    >>> build_array([5, 0, 1, 2, 3, 4])
    [4, 5, 0, 1, 2, 3]
    '''
    new = []
    for element in elements:
        new.append(elements[element])
    return new


if __name__ == "__main__":
    import doctest

    doctest.testmod()
