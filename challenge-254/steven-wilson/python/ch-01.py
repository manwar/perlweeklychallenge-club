#!/usr/bin/env python3

import math


def is_power_three(number):
    ''' Given a positive integer. Returns true if the given integer is a power
    of three otherwise returns false.

    >>> is_power_three(27)
    True
    >>> is_power_three(0)
    True
    >>> is_power_three(6)
    False
    '''
    cr = round(math.pow(number, 1/3), 6)
    return ((cr - int(cr)) == 0)


if __name__ == "__main__":
    import doctest

    doctest.testmod()
