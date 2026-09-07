#!/usr/bin/env python3

"""Simon's solution to task 2 of The Weekly Challenge"""

import re
import sys


def get_change(ints, p):
    """
    Compare that integers at ints[p] and ints[p+1]. Return if the second one
    is higher, lower or the same.
    """
    i = ints[p]
    j = ints[p + 1]
    if i == j:
        return "s"
    return "h" if j > i else "l"


def zigzag_subway(ints: list[int]) -> int:
    """
    Find the length of the longest contiguous sub-array where the numbers
    alternate between strictly increasing and strictly decreasing (a ZigZag
    pattern).

    Params:
        ints (list): A list of integers

    Returns:
        The length of the longest sub array matching the criteria
    """
    # Get pattern (higher, lower, same)
    pattern = "".join(get_change(ints, i) for i in range(len(ints) - 1))

    # Find longest run of alternating higher and lower characters, as well as
    #  a single one.
    return max(
        (
            len(match.group(0)) + 1
            for match in re.finditer("(h?(?:lh)+|l?(?:hl)+|[hl])", pattern)
        ),
        default=1,
    )


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = zigzag_subway(array)
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
