#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge"""

import string
import sys


def missing_letter(seq: list[str]) -> str:
    """
    Find the unknown letter.

    Params:
        seq (list[str]): A space separate string with four lower case letters and one question

    Returns:
        str: The letter that the question mark represents
    """
    # Check we have valid input
    if (
        len(seq) != 5 or
        seq.count("?") != 1 or
        any(s not in string.ascii_lowercase+"?" for s in seq)
    ):
        raise ValueError("I expected four lower case letters and a question mark")

    # Get the position of the unknown letter
    pos = seq.index("?")

    if pos == 0:
        # If it is first, we take the even difference from the second letter
        return chr(ord(seq[1]) - (ord(seq[3]) - ord(seq[2])))

    # Otherwise we use the difference from the previous letter
    diff_pos = [None, 2, 3, 0, 1][pos]
    return chr(ord(seq[pos-1]) + ord(seq[diff_pos+1]) - ord(seq[diff_pos]))


def main():
    """Convert command line input into parameters for the function and display result"""
    result = missing_letter(sys.argv[1:])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
