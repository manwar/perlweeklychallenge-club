#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge"""

from collections import Counter
import sys


def largest_substring(input_string: str) -> int:
    """
    Return the length of the largest substring between two equal characters
    excluding the two characters. Return -1 if there is no such substring.

    Params:
        input_string (str): The input string

    Returns:
        int: The length of the largest substring
    """

    # Calculate the frequency of each letter
    freq = Counter(input_string)
    largest = -1

    # Loop through all the letters found
    for letter, count in freq.items():
        if count > 1:
            # If the letter occurs multiple times, calculate the span and
            #  update the largest value if required.
            substr = input_string.rindex(letter) - input_string.index(letter) - 1
            if substr > largest:
                largest = substr

    return largest


def main():
    """Convert command line input into parameters for the function and display result"""
    result = largest_substring(sys.argv[1])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
