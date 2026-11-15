#!/usr/bin/env python3

"""Simon's solution to task 1 of The Weekly Challenge"""

from collections import Counter
import sys


def longest_repeating_char(input_string: str, k: int) -> int:
    """
    Choose any character of the input string and change it to another
    character. You may perform this operation up to k times. Return the
    length of the longest reachable substring of a single letter.

    Params:
        input_string (str): The supplied string
        k (int): The number of characters that can be changed

    Returns:
        The length of the longest substring that matches the criteria
    """
    string_length = len(input_string)

    # Generate all possible substrings, starting with longest first
    for length in range(string_length, 0, -1):
        for start in range(0, string_length - length + 1):
            substr = input_string[start : start + length]

            # Find the frequency of the most used character
            max_freq = max(Counter(substr).values())

            # If the highest frequency + letter we can change (k) is higher
            #  than the length, we have the solution
            if max_freq + k >= length:
                return length

    return 0


def main():
    """Convert command line input into parameters for the function and display result"""
    result = longest_repeating_char(sys.argv[1], int(sys.argv[2]))
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
