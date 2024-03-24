#!/usr/bin/env python3

import sys


def multiple_by_two(ints: list, start: int) -> int:
    """Multiple the start number by 2 if it is in the list

    Args:
        ints (list): List of integers
        start (int): The starting number

    Returns:
        int: The first value that isn't in the string
    """

    solution = start
    while solution in ints:
        solution *= 2

    return solution


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    start = array.pop()
    result = multiple_by_two(array, start)
    print(result)


if __name__ == '__main__':
    main()
