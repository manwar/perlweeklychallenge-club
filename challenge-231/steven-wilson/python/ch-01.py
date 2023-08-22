#!/usr/bin/env python3


def pluck_min_max(elements):
    """Return array with min and max elements removed
    >>> pluck_min_max( [3, 2, 1, 4] )
    [3, 2]
    >>> pluck_min_max( [3, 1] )
    -1
    >>> pluck_min_max( [2, 1, 3] )
    [2]
    """
    if len(elements) < 3:
        return -1
    (min, max) = [sorted(elements)[i] for i in (0, -1)]
    for i in (min, max):
        elements.remove(i)
    return elements


if __name__ == "__main__":
    import doctest

    doctest.testmod()
