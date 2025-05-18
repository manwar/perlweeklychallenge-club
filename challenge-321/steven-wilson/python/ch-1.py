#!/usr/bin/env python3

from numbers import Real


def distinct_average(numbers):
    """ Given an array of numbers with even length, return the count of
    distinct average. The average is calculate by removing the minimum and the
    maximum, then average of the two.

    >>> distinct_average([1, 2, 4, 3, 5, 6])
    1
    >>> distinct_average([0, 2, 4, 8, 3, 5])
    2
    >>> distinct_average([7, 3, 1, 0, 5, 9])
    2
    """
    if not all(isinstance(n, (Real)) and not isinstance(n, bool) for n in numbers):
        raise TypeError("Array should comtain only numbers")

    if len(numbers) % 2 != 0:
        raise ValueError("Array should be of even length")

    sorted_numbers = sorted(numbers)
    split = int(len(sorted_numbers) / 2)
    return len({(a + b) / 2 for a, b in
                zip(sorted_numbers[:split], sorted_numbers[:split-1:-1])})


if __name__ == "__main__":
    import doctest

    doctest.testmod(verbose=True)
