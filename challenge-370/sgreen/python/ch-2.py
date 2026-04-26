#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge"""

from collections import Counter
import sys


def same_letters(str1: str, str2: str) -> bool:
    """Compare two strings to see if they contain the same letters"""
    return Counter(str1) == Counter(str2)


def scramble_string(str1: str, str2: str) -> bool:
    """
    Recursive function to scramble a string to see if it can be converted into
    the second string

    Params:
        str1 (str): The first string
        str2 (str): The second string

    Returns:
        bool: Whether the first string can be converted to the second string
              using a defined set of rules
    """

    # Check each string has the same frequency of letters
    if not same_letters(str1, str2):
        # If they don't, there is no possible solution
        return False

    # If there are one or two letters, they are identical or swapped
    if len(str1) < 3:
        return True

    for split_pos in range(1, len(str1)):
        # Consider scrambling letters each side of split_pos
        if (scramble_string(str1[:split_pos], str2[:split_pos]) and
                scramble_string(str1[split_pos:], str2[split_pos:])):
            return True

        # Consider swapping the split parts before scrambling letters
        if (scramble_string(str1[:split_pos], str2[-split_pos:]) and
                scramble_string(str1[split_pos:], str2[:-split_pos])):
            return True

    return False


def main():
    """Convert command line input into parameters for the function and display result"""
    result = scramble_string(sys.argv[1], sys.argv[2])
    print("true" if result else "false")


# Call main if run from the command line
if __name__ == "__main__":
    main()
