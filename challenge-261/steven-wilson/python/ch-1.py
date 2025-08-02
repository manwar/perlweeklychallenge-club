#!/usr/bin/env python3


def element_digit_sum(*elements):
    ''' Given an array of integers, evaluate the absolute difference between
    element and digit sum of the given array.
    >>> element_digit_sum(1,2,3,45)
    36
    >>> element_digit_sum(1,12,3)
    9
    >>> element_digit_sum(1,2,3,4)
    0
    >>> element_digit_sum(236, 416, 336, 350)
    1296
    '''
    return abs(sum_digits(elements) - sum(elements))


def sum_digits(elements):
    return sum(int(char) for elem in elements for char in str(elem))


if __name__ == "__main__":
    import doctest

    doctest.testmod()
