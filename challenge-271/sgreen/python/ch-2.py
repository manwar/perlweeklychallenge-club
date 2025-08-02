#!/usr/bin/env python3

import sys


def sort_by_1_bits(ints: list) -> list:
    """
    Sorts a list of integers based on the number of set bits (1s) in their
    binary representation. If they are equal, they are sorted by their value.

    Args:
        ints (list): A list of integers to be sorted.

    Returns:
        list: A new list of integers sorted based on the criteria above.
    """
    sorted_ints = sorted(ints, key=lambda x: (bin(x).count('1'), x))
    return sorted_ints


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = sort_by_1_bits(array)
    print(tuple(result))


if __name__ == '__main__':
    main()
