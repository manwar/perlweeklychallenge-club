#!/usr/bin/env python3


def remove_one(elements):
    """removing ONLY one integer makes it strictly increasing order
    >>> remove_one( [0, 2, 9, 4, 6] )
    True
    >>> remove_one( [5, 1, 3, 2] )
    False
    >>> remove_one( [2, 2, 3] )
    True
    >>> remove_one( [1, 2, 3, 1, 2, 3] )
    False
    >>> remove_one( [1, 2, 3, 1])
    True
    """
    remove = 0
    for i in range(len(elements) - 1):
        if(elements[i] > elements[i+1]):
            remove += 1
            if (i > 0) and (i < len(elements) - 2) and (elements[i-1] > elements[i+1]):
                remove += 1
            if remove > 1:
                return False
    return True


if __name__ == "__main__":
    import doctest

    doctest.testmod()
