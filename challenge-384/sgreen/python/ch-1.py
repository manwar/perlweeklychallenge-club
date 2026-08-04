#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge" ""

import sys


def base_n(num: int, base: int) -> str:
    """
    Convert the specified integer to the specified base

    Params:
        num (int): The number to convert
        base (int): The base to convert it to

    Returns:
        str: The number in the specified base
    """
    # Check we have a valid base and a non-negative number
    if not 2 <= base <= 64:
        raise ValueError(f"Invalid base value: {base}")
    if num < 0:
        raise ValueError(f"Number {num} must be non-negative")

    # Convert the number into digits in the specified base
    digits = []
    while True:
        i, j = divmod(num, base)
        digits.insert(0, j)

        if i == 0:
            break

        num = i

    # The string representation of 64 digits
    alphabet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz+/"

    # Return the string representation of the digits
    return "".join(alphabet[i] for i in digits)


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = base_n(array[0], array[1])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
