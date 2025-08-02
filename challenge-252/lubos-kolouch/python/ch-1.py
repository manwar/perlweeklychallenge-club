#!/usr/bin/env python


def sum_of_special_squares(ints: list[int]) -> int:
    """
    Calculates the sum of squares of all special elements in the array.
    A special element is defined as one whose 1-based index divides the length of the array.

    :param ints: List of integers
    :return: Sum of squares of special elements
    """
    n = len(ints)
    return sum(ints[i - 1] ** 2 for i in range(1, n + 1) if n % i == 0)


# Tests
assert sum_of_special_squares([1, 2, 3, 4]) == 21
assert sum_of_special_squares([2, 7, 1, 19, 18, 3]) == 63
