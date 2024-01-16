#!/usr/bin/env python3


def special_numbers(*integers):
    '''Given an array of integers, find the sum of the squares of all special
    elements of the array.

    An element $int[i] of @ints is called special if i divides n, i.e.
    n % i == 0.  Where n is the length of the given array. The array is
    1-indexed.
    >>> special_numbers(1, 2, 3, 4)
    21
    >>> special_numbers(2, 7, 1, 19, 18, 3)
    63
    '''
    len_i = len(integers)
    return sum(integers[x-1] * integers[x-1] for x in range(1, len_i+1) if len_i % x == 0)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
