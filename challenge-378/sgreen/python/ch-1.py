#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge"""

import sys


def second_largest_digit(input_string) -> int:
    """
    Return the second largest distinct digit in the given string. Return
    -1 if none found.

    Params:
        input_string (str): The supplied string

    Returns:
        int: The second largest digit or -1 if there isn't one.
    """

    digits = set(int(c) for c in input_string if c.isdigit())
    return sorted(digits)[-2] if len(digits) > 1 else -1


def main():
    """Convert command line input into parameters for the function and display result"""
    result = second_largest_digit(sys.argv[1])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
