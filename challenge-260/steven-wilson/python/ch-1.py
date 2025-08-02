#!/usr/bin/env python3


def unique_occurences(*elements):
    '''
    >>> unique_occurences(1,2,2,1,1,3)
    1
    >>> unique_occurences(1,2,3)
    0
    >>> unique_occurences(-2,0,1,-2,1,1,0,1,-2,9)
    1
    '''
    if not all(isinstance(elem, int) for elem in elements):
        raise ValueError("Input must consist of integers")

    from collections import Counter

    counts = Counter(elements)
    occurences = counts.values()
    if len(counts) == len(set(occurences)):
        return 1
    else:
        return 0


if __name__ == "__main__":
    import doctest

    doctest.testmod()
