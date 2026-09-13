#!/usr/bin/env python3

"""Simon's solution to task 1 of The Weekly Challenge"""

import re
import sys


def expand_brackets(match_obj: re.Match) -> str:
    """
    Expand the inner brackets.

    Params:
        match_obj(re.Match): The third item is the string inside the
        brackets, and the second is the multiplier value.

    Returns:
        str: The new string count repeated the required number of times
    """
    multiplier = int(match_obj[1])
    s = match_obj[2]
    return s * multiplier


def decode_string(input_string: str) -> str:
    """
    Return the decoded string of the given encoded string.

    Params:
        input_string (str): The chemical compound

    Returns:
        str: The number of atoms for each element
    """

    # Keep expanding inner parentheses while there is still some
    while re.search(r"\d+\[[A-Z0-9]+\]", input_string, flags=re.I):
        input_string = re.sub(
            r"(\d+)\[([^\[\]]+)\]", expand_brackets, input_string, flags=re.I
        )

    # Check that the final string is as expected
    if "[" in input_string or "]" in input_string:
        raise ValueError("Invalid input")

    return input_string


def main():
    """Convert command line input into parameters for the function and display result"""
    result = decode_string(sys.argv[1])
    print('"' + result + '"')


# Call main if run from the command line
if __name__ == "__main__":
    main()
