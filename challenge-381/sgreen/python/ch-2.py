#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge"""

import sys


def smaller_greater_element(ints: list[int]) -> int:
    """
    Count the number of elements that have both a strictly smaller and greater
    element in the given array

    Params:
        ints list[int]: The supplied array

    Returns:
        int: The number of items in the list that satisfy the criteria
    """
    # Exclude the smaller and largest number, and count the rest
    excluded_values = {min(ints), max(ints)}
    return sum(1 for i in ints if i not in excluded_values)


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = smaller_greater_element(array)
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
