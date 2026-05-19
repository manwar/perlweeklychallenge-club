#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge"""

import sys


def equal_list(arr1: list[str], arr2: list[str]) -> bool:
    """
    Return True if the two given array represent the same strings otherwise False

    Params:
        arr1 (list[str]): The first list of strings
        arr2 (list[str]): The second list of strings

    Returns:
        bool: If the two lists make the same string
    """
    return ''.join(arr1) == ''.join(arr2)


def main():
    """Convert command line input into parameters for the function and display result"""
    # For CLI, words in each list are separated by commas
    result = equal_list(sys.argv[1].split(","), sys.argv[2].split(","))
    print("true" if result else "false")


# Call main if run from the command line
if __name__ == "__main__":
    main()
