#!/usr/bin/env python3


from itertools import permutations


def concate_to_number(elements):
    '''Concatinate a list of integers to an integer
    >>> concate_to_number([9, 8, 1])
    981
    >>> concate_to_number([0, 1, 2])
    12
    '''
    return int("".join(map(str, elements)))


def largest_of_three(*elements):
    '''Return the largest number formed by concatenating some of the
    given integers in any order which is also multiple of 3. Return -1
    if none found.
    >>> largest_of_three(8, 1, 9)
    981
    >>> largest_of_three(8, 6, 7, 1, 0)
    8760
    >>> largest_of_three(1)
    -1
    '''
    ints = []
    for i, elem in enumerate(elements, 1):
        for perm in permutations(elements, i):
            concate_number = concate_to_number(perm)
            if concate_number % 3 == 0:
                ints.append(concate_number)
    if len(ints) > 0:
        return max(ints)
    else:
        return -1


if __name__ == "__main__":
    import doctest

    doctest.testmod()
