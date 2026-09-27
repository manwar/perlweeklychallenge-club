#!/usr/bin/env python3

"""Simon's solution to task 1 of The Weekly Challenge"""

import sys


def convert_palindrome(input_string: str) -> str:
    """
    Convert the given string to palindrome by adding characters in front of it.

    Params:
        input_string(str): The supplied string

    Returns:
        str: The shortest possible palindromic string
    """
    last_pos = len(input_string)

    # Looking for the longest possible palindrome pinned to the start
    for pos in range(last_pos, 1, -1):
        substr = input_string[:pos]
        if substr == substr[::-1]:
            # Reverse the character at and after pos only
            return input_string[last_pos : pos - 1 : -1] + input_string

    # Reverse all characters except the first one
    return input_string[last_pos:0:-1] + input_string


def main():
    """Convert command line input into parameters for the function and display result"""
    result = convert_palindrome(sys.argv[1])
    print('"' + result + '"')


# Call main if run from the command line
if __name__ == "__main__":
    main()
