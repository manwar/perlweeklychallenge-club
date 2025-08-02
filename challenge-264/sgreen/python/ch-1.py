#!/usr/bin/env python3

import string
import sys


def greatest_letter(s: str) -> str | None:
    """Write a script to return the greatest english letter in the given string.

    Args:
        s (str): The string we are inspecting

    Returns:
        str|None: The greatest letter that occurs in both lower case and upper case
    """
    # Go through each letter in reverse, starting at 'Z'
    for letter in string.ascii_uppercase[::-1]:
        if letter in s and letter.lower() in s:
            # We have found a match
            return letter

    # There was no match
    return None


def main():
    result = greatest_letter(sys.argv[1])
    print(result if result else "''")


if __name__ == '__main__':
    main()
