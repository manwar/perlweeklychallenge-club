#!/usr/bin/env python3


from itertools import combinations


def group_hero(*elements):
    '''
    Return the sum of the powers of all possible combinations; power is
    defined as the square of the largest number in a sequence,
    multiplied by the smallest.
    >>> group_hero(2, 1, 4)
    141
    '''
    sum_of_powers = 0
    for i, elem in enumerate(elements, 1):
        for comb in combinations(elements, i):
            sum_of_powers += ((max(comb) ** 2) * min(comb))
    return sum_of_powers


if __name__ == "__main__":
    import doctest

    doctest.testmod()
