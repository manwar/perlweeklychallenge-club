#!/usr/bin/env python3

"""Simon's solution to task 2 of The Weekly Challenge"""

import sys


def calc_binary_reflection(i: int) -> int:
    """Reverse the binary representation and return the resulting integer"""
    b = bin(i)[2:]
    return int(b[::-1], 2)


def binary_reflection(ints: list[int]) -> list[int]:
    """
    Sort the given array in ascending order based on the binary reflection
    of each element. If two different numbers have the same binary
    reflection, the smaller original number should appear first.

    Params:
        ints (list[int]): The list of integers

    Returns:
        list[int]: The integers sorted by the specified criteria.
    """
    return sorted(sorted(ints), key=calc_binary_reflection)


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = binary_reflection(array)
    print(tuple(result))


# Call main if run from the command line
if __name__ == "__main__":
    main()
