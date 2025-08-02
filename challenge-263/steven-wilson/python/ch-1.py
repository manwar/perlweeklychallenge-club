#!/usr/bin/env python3


def target_index(*elements, target):
    ''' Given an array of integers and a target element, return the list of
    indices in the sorted array where the element is same as the given target
    element.
    >>> target_index(1, 5, 3, 2, 4, 2, target=2)
    [1, 2]
    >>> target_index(1, 2, 4, 3, 5, target = 6)
    []
    >>> target_index(5, 3, 2, 4, 2, 1, target = 4)
    [4]
    '''
    return [i for i, elem in enumerate(sorted(elements)) if elem == target]


if __name__ == "__main__":
    import doctest

    doctest.testmod()
