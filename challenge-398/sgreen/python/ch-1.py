#!/usr/bin/env python3

"""Simon's solution to task 1 of The Weekly Challenge"""

import sys


def divisible_average(ints: list[int]) -> int:
    """
    Return the closest integer to the mean value of all even integers that
    are divisible by 3. If none is divisible, return 0.

    Params:
        ints (list[ints]): The supplied list of integers

    Returns:
        int: The closest integer that meets the criteria
    """

    # Eligible integers are divisible by 6.
    eligible_ints = [i for i in ints if i % 6 == 0]

    if not eligible_ints:
        # No eligible integers found
        return 0

    # Return the closest integer (bankers rounding)
    return round(sum(eligible_ints) / len(eligible_ints))


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = divisible_average(array)
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
