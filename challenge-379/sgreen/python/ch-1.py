#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge"""

import sys


def reverse_string(input_string) -> str:
    """
    Reverse the character in a string without using the reverse method

    Params:
        input_string (str): The input string

    Returns:
        str: The reverse of the supplied string
    """
    result_string = ''

    for i in range(len(input_string) - 1, -1, -1):
        result_string += input_string[i]

    return result_string


def main():
    """Convert command line input into parameters for the function and display result"""
    result = reverse_string(sys.argv[1])
    print('"' + result + '"')


# Call main if run from the command line
if __name__ == "__main__":
    main()
