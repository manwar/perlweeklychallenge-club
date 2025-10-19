#!/usr/bin/env python3

from decimal import Decimal
import sys


def zero_friend(numbers: list) -> Decimal:
    """
    Return the number closest to zero from the list.

    Input: A list of numbers

    Returns: The number closest to zero
    """
    return min(abs(n) for n in numbers)


def main():
    # Convert input into numbers
    array = [Decimal(n) for n in sys.argv[1:]]
    result = zero_friend(array)
    print(result)


if __name__ == '__main__':
    main()
