#!/usr/bin/env python3

import sys


def sum_difference(ints: list) -> int:
    """Calculate the absolute difference between digit sum and element
    sum of the given list.

    Args:
        ints (list): A list of positive integers

    Returns:
        int: The absolute difference.
    """
    # Check we are only given positive integers
    if any(i < 1 for i in ints):
        raise ValueError('Only positive integers allowed')

    difference = 0
    for i in ints:
        # Single digit integers have no difference
        if i > 9:
            # Calculate the difference between the number and the sum of the
            #  individual digits
            difference += i - sum(int(d) for d in str(i))

    return abs(difference)


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = sum_difference(array)
    print(result)


if __name__ == '__main__':
    main()
