#!/usr/bin/env python3

"""Simon's solution to task 1 of The Weekly Challenge"""

import sys


def asp(ints: list[int]) -> int:
    """
    Return the smallest absent positive integer such that it is strictly
    greater than the average of all elements in the given array.

    Params:
        ints (list[int]): The list of integers

    Returns:
        int: The smallest positive integer that meets the criteria.
    """
    # Calculate the average
    average = sum(ints) // len(ints)

    # The first possible answer is one more than the average or 1, whichever
    #  is greater.
    result = max(1, average + 1)

    while result in ints:
        # This integer is in the list, consider the next one
        result += 1

    return result


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = asp(array)
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
