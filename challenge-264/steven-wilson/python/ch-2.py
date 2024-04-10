#!/usr/bin/env python3


def target_array(source, indices):
    ''' Given two arrays of integers, source and indices. The indices can
    only contains integers 0 <= i < size of source.  Return a target array by
    insert at index indices[i] the value source[i].
    >>> target_array((0, 1, 2, 3, 4), (0, 1, 2, 2, 1))
    [0, 4, 1, 3, 2]
    >>> target_array((1, 2, 3, 4, 0), (0, 1, 2, 3, 0))
    [0, 1, 2, 3, 4]
    >>> target_array([1], [0])
    [1]
    '''
    size_source = len(source)
    if not all(0 <= x < size_source for x in indices):
        raise ValueError("Values in indices must be in the range 0 and the size of source")

    if len(source) != len(indices):
        raise ValueError("Length of source and indices must be equal")

    result = []
    for i, _ in enumerate(source):
        result.insert(indices[i], source[i])
    return result


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
