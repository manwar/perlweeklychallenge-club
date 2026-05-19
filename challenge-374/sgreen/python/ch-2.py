#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge"""

from collections import Counter
import re
import sys


def largest_number(input_string) -> int:
    """
    Generate the largest number with all digits the same in the given string

    Params:
        input_string(str): The string to use

    Returns:
        int: The largest number found.
    """
    # Check we only have numbers
    if not re.search(r'^\d+$', input_string):
        raise ValueError("String should only contain numbers")

    # Calculate the frequency of all digits
    largest_number = 0
    freq = Counter(input_string)

    for digit, count in freq.items():
        # Compute the number of the concatenated digits
        number = int(digit * count)
        # Update largest_number if required.
        if number > largest_number:
            largest_number = number

    return largest_number

def main():
    """Convert command line input into parameters for the function and display result"""
    result = largest_number(sys.argv[1])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
