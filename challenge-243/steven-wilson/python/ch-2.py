#!/usr/bin/env python3

from itertools import product
from math import floor


def floor_sum(*elements):
    '''
     return the sum of floor(nums[i] / nums[j]) where 0 <= i,j < nums.length
    >>> floor_sum(2, 5, 9)
    10
    >>> floor_sum(7, 7, 7, 7, 7, 7, 7)
    49
    '''
    sum = 0
    prod = product(range(len(elements)), repeat=2)
    for i, j in prod:
        if 0 <= i and j < len(elements):
            sum += floor(elements[i] / elements[j])
    return sum


if __name__ == "__main__":
    import doctest

    doctest.testmod()
