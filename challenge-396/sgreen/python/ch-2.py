#!/usr/bin/env python3

"""Simon's solution to task 2 of The Weekly Challenge"""

import re
import sys


def get_direction(i, j):
    if i == j:
        return "s"
    return "u" if j > i else "d"


def trionic_array(ints: list[int]) -> bool:
    direction = "".join(
        get_direction(ints[i - 1], ints[i]) for i in range(1, len(ints))
    )
    return bool(re.search("^u+d+u+$", direction))


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = trionic_array(array)
    print("true" if result else "false")


# Call main if run from the command line
if __name__ == "__main__":
    main()
