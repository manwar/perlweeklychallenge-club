#!/usr/bin/env python3


def running_sum(elements):
    """ Returns the running sum of the given array
    >>> running_sum([1, 2, 3, 4, 5])
    [1, 3, 6, 10, 15]
    >>> running_sum([1, 1, 1, 1, 1])
    [1, 2, 3, 4, 5]
    >>> running_sum([0, -1, 1, 2])
    [0, -1, 0, 2]
    >>> running_sum([])
    []
    """
    if len(elements) <= 1: return elements
    elements[1] = elements[0] + elements[1]
    return [elements[0]] + running_sum(elements[1:])


if __name__ == "__main__":
    import doctest

    doctest.testmod()
