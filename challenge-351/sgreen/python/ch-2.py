#!/usr/bin/env python3

from decimal import Decimal
import sys


def arithmetic_progression(ints: list) -> bool:
    # Sort the list and compute the difference between the first two
    sorted_ints = sorted(ints)
    diff = sorted_ints[1] - sorted_ints[0]

    # Check the difference between each pair of adjacent values
    for i in range(2, len(sorted_ints)):
        if sorted_ints[i] - sorted_ints[i - 1] != diff:
            return False

    return True


def main():
    # Convert input into decimal values
    array = [Decimal(n) for n in sys.argv[1:]]
    result = arithmetic_progression(array)
    print(result)


if __name__ == '__main__':
    main()
