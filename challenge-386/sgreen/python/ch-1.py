#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge" ""

import string
import sys


def reverse_base(input_string: str, base: int) -> int:
    alphabet = "0123456789" + string.ascii_uppercase + string.ascii_lowercase + "+/"

    # Truncate the alphabet to the correct base
    alphabet = alphabet[:base]

    # Convert each character to its base-10 value
    try:
        digits = [alphabet.index(digit) for digit in input_string]
    except ValueError:
        raise ValueError("Invalid input for the specified base")

    # Calculate the base-10 integer
    output = 0
    for digit in digits:
        output *= base
        output += digit

    return output


def main():
    """Convert command line input into parameters for the function and display result"""
    result = reverse_base(sys.argv[1], int(sys.argv[2]))
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
