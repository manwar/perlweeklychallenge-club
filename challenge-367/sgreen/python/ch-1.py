#!/usr/bin/env python3

import re
import sys


def max_odd_binary(input_string: str) -> str:
    """
    Rearrange the bits in such a way that the resulting binary number is the
    maximum odd binary number

    Params:
        input_string: A binary string with at least one 1

    Returns:
        str: The binary string that matches the criteria
    """
    # Check we have a binary string with at least one 1.
    if not re.search(r'^[01]*1[01]*$', input_string):
        raise ValueError("Input not in expected format")

    # Count the number of zeros and ones
    zeros = input_string.count("0")
    ones = input_string.count("1")

    # Compute the maximum number
    return "1" * (ones-1) + "0" * zeros + "1"


def main():
    result = max_odd_binary(sys.argv[1])
    print(result)


if __name__ == "__main__":
    main()
