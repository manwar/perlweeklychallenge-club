#!/usr/bin/env python3

import sys

from itertools import combinations


def total_xor(ints: list) -> int:
    """
    Calculate the total XOR of all combinations of integers in the list.
    :param ints: List of integers to calculate the total XOR.
    :return: Total XOR as a hexadecimal string.
    """

    total = 0
    for i in range(1, len(ints) + 1):
        # Generate all combinations of length i
        # and calculate the XOR for each combination
        for combo in combinations(ints, i):
            xor_value = 0
            for num in combo:
                xor_value ^= num
            total += xor_value

    return total


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = total_xor(array)
    print(result)


if __name__ == '__main__':
    main()
