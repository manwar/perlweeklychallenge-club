#!/usr/bin/env python3


def count_smaller(*elements):
    '''
    Calculate the number of integers smaller than the integer at each index
    >>> count_smaller(8, 1, 2, 2, 3)
    (4, 0, 1, 1, 3)
    >>> count_smaller(6, 5, 4, 8)
    (2, 1, 0, 3)
    >>> count_smaller(2, 2, 2)
    (0, 0, 0)
    '''
    sorted_elements = sorted(elements)
    smaller = []

    for elem in elements:
        for i, sorted_elem in enumerate(sorted_elements):
            if elem <= sorted_elem:
                smaller.append(i)
                break
    return tuple(smaller)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
