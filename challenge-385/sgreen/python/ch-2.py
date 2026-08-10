#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge" ""

import re
import sys


def outermost_parentheses(input_string: str) -> str:
    """
    Return the string after removing the outermost parentheses of every
    primitive string in the primitive decomposition of the given string.

    Params:
        input_string(str): The string to parse

    Returns:
        str: The string without the outermost parentheses
    """
    # Check the input string is valid
    if not re.search(r"^[()]+$", input_string):
        raise ValueError("Invalid input")

    output = ""
    open_count = 0

    # Go through each character, increasing open_count as needed. If it is not
    #  1, then it's an inner parentheses and we include it in the output
    for char in input_string:
        if char == "(":
            open_count += 1

        if open_count != 1:
            output += char

        if char == ")":
            open_count -= 1

        # Check we don't have too many closing parentheses
        if open_count < 0:
            raise ValueError("Too many closing parentheses")

    # Check that we have a matching count of open and closed parentheses.
    if open_count != 0:
        raise ValueError("Not enough closing parentheses")

    return output


def main():
    """Convert command line input into parameters for the function and display result"""
    result = outermost_parentheses(sys.argv[1])
    print('"' + result + '"')


# Call main if run from the command line
if __name__ == "__main__":
    main()
