#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge" ""

import re
import sys


def generate_substring(l: int) -> tuple:
    "Generate tuple of l zeros and l ones and visa versa"
    return ("0" * l + "1" * l, "1" * l + "0" * l)


def special_binary_substrings(input_string: str) -> list[str]:
    """
    Return all non-empty substrings (distinct) that have the same number of
    0’s and 1’s, and all the 0’s and all the 1’s in these substrings are
    grouped consecutively.

    Params:
        input_string: A binary string

    Returns:
        list(str): Substrings that match the criteria
    """

    # Check the input only contains zeros and ones
    if not re.search(r"^[01]+$", input_string):
        raise ValueError("Invalid input provided")

    # Record all valid substrings
    half_length = int(len(input_string) / 2)
    valid_substring = {
        substring
        for l in range(1, half_length + 1)
        for substring in generate_substring(l)
    }

    # Find the substrings that are valid
    results = []
    for start in range(len(input_string) - 1):
        for end in range(start + 1, len(input_string), 2):
            substring = input_string[start : end + 1]
            if substring in valid_substring:
                results.append(substring)

    return results


def main():
    """Convert command line input into parameters for the function and display result"""
    result = special_binary_substrings(sys.argv[1])
    print("(" + ", ".join(f'"{r}"' for r in result) + ")")


# Call main if run from the command line
if __name__ == "__main__":
    main()
