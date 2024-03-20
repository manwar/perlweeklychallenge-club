#!/usr/bin/env python3


def multiply_by_two(*elements, start):
    ''' Given an array of integers and a start integer

    a) Look for start in the array, if found multiply the number by 2
    b) If not found stop the process otherwise repeat

    In the end return the final value.

    >>> multiply_by_two(5,3,6,1,12, start=3)
    24
    >>> multiply_by_two(1,2,4,3, start=1)
    8
    >>> multiply_by_two(5,6,7, start=2)
    2
    '''
    if not all(isinstance(elem, int) for elem in elements) or not isinstance(start, int):
        raise ValueError('Input must consist of integers')

    elements_set = set(elements)
    while start in elements_set:
        start *= 2

    return start


if __name__ == "__main__":
    import doctest

    doctest.testmod()
