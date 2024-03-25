#!/usr/bin/env python3


def count_equal_divisible(*elements, divisor):
    '''
    Given an array of integers, @ints and an integer $k.  Return the number of
    pairs (i, j) where:
    a) 0 <= i < j < size of @ints
    b) ints[i] == ints[j]
    c) i x j is divisible by k
    >>> count_equal_divisible(3,1,2,2,2,1,3, divisor = 2)
    4
    >>> count_equal_divisible(1,2,3, divisor = 1)
    0
    '''
    if not isinstance(divisor, int):
        raise TypeError("Divisor must be an integer")

    if not all(isinstance(elem, int) for elem in elements):
        raise TypeError("All elements must be integers")

    count = 0
    length_elements = len(elements)

    for i, val_i in enumerate(elements):
        for j in range(i + 1, length_elements):
            val_j = elements[j]
            if (val_i == val_j) and ((i * j) % divisor == 0):
                count += 1

    return count


if __name__ == "__main__":
    import doctest

    doctest.testmod()
