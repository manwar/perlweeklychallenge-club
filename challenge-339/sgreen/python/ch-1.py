#!/usr/bin/env python3

import sys
from itertools import combinations


def max_diff(ints: list) -> int:
    """
    Given a list of integers, find the maximum difference between the products
    of any two pairs of integers from the list.

    Args:
        ints (list): List of integers.

    Returns:
        int: Maximum difference between products of two pairs.
    """
    solution = 0

    # Compute all combinations of 4 integers
    for c in combinations(ints, 4):
        # Calculate the maximum difference for this combination
        diff = max(
            abs((c[0] * c[1]) - (c[2] * c[3])),
            abs((c[0] * c[2]) - (c[1] * c[3])),
            abs((c[0] * c[3]) - (c[1] * c[2])),
        )
        if diff > solution:
            solution = diff

    return solution


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = max_diff(array)
    print(result)


if __name__ == '__main__':
    main()
