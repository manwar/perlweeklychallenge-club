#!/usr/bin/env python3

from operator import itemgetter


def sort_by_1_bits(*integers):
    ''' Given an array of integers, sort the integers in ascending order by the
    number of 1 bits in their binary representation. In case more than one
    integers have the same number of 1 bits then sort them in ascending order.
    >>> sort_by_1_bits(0, 1, 2, 3, 4, 5, 6, 7, 8)
    (0, 1, 2, 4, 8, 3, 5, 6, 7)
    >>> sort_by_1_bits(1024, 512, 256, 128, 64)
    (64, 128, 256, 512, 1024)
    '''
    number_of_1_bits = ((str(bin(i)).count('1'), i) for i in sorted(integers))
    return tuple([i[1] for i in sorted(number_of_1_bits, key=itemgetter(0))])


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
