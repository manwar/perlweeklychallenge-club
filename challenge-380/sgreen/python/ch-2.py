#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge"""

import re
import sys


def reverse_degree(input_string: str) -> int:
    """
    find the reverse degree of the given string.

    For each character, multiply its position in the reversed alphabet (a = 26,
    b = 25, …, z = 1) with its position in the string. Sum these products for
    all characters in the string to get the reverse degree.

    Params:
        input_string (str): The supplied string

    Returns:
        int: The reverse degree
    """
    if not re.search("^[a-zA-Z]*$", input_string):
        raise ValueError("String must only contain English letters")

    numbers = [ord("z") - ord(char) + 1 for char in input_string.lower()]
    return sum(number * pos for number, pos in enumerate(numbers, start=1))


def main():
    """Convert command line input into parameters for the function and display result"""
    result = reverse_degree(sys.argv[1])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
