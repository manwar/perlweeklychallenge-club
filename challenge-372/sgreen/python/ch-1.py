#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge"""

import sys


def rearrange_space(input_string: str) -> str:
    """
    Rearrange the spaces in a supplied string so that there is an equal number
    of spaces between every pair of adjacent words and that number is
    maximized. If you can’t distribute, place the extra spaces at the end.

    Params:
        input_string (str): The supplied string

    Returns:
        str: The reformated string
    """

    # Split the input string and count the spaces
    words = input_string.split()
    spaces = input_string.count(" ")

    # To avoid a division by zero error, handle the single word case
    if len(words) == 1:
        return words[0] + " " * spaces

    # Calculate how many spaces are required and return the string
    spaces_between_words, spaces_at_end = divmod(spaces, len(words)-1)
    return (" " * spaces_between_words).join(words) + " " * spaces_at_end


def main():
    """Convert command line input into parameters for the function and display result"""
    result = rearrange_space(sys.argv[1])
    print('"' + result + '"')


# Call main if run from the command line
if __name__ == "__main__":
    main()
