#!/usr/bin/env python3

"""Simon's solution to task 1 of The Weekly Challenge"""

import re
import sys


def rearrange_binstr(input_string: str) -> int:
    """
    Return the number of steps to re-arrange the given binary string so that
    all occurrences of “01” are simultaneously replaced with “10” until no
    occurrences of “01” exist.

    Parameters:
        input_string (str): The supplied string

    Returns:
        int: The number of steps taken to reach the solution
    """
    # Check the input is valid
    if not re.search("^[01]+$", input_string):
        raise ValueError("Invalid input")

    # Count the number times we swap '01' with '10'
    count = 0
    while "01" in input_string:
        count += 1
        input_string = re.sub("01", "10", input_string)

    return count


def main():
    """Convert command line input into parameters for the function and display result"""
    result = rearrange_binstr(sys.argv[1])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
