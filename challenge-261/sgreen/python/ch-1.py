#!/usr/bin/env python3

import sys


def element_digit_sum(ints: list) -> int:
    """Calculate the absolute difference between the element sum and the sum
    of each digit

    Args:
        ints (list): List of integers

    Returns:
        int: The absolute difference
    """

    element_sum = sum(ints)
    digit_sum = sum(int(i) for s in map(str, ints) for i in s)
    return abs(element_sum - digit_sum)


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = element_digit_sum(array)
    print(result)


if __name__ == '__main__':
    main()
