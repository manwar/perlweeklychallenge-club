#!/usr/bin/env python3

import sys

def covert_string(s: str) -> str:
    """Convert a string by treating '#' as a backspace character

    Args:
        s (str): The original string

    Returns:
        str: The converted string
    """

    new_string = ''
    for c in s:
        if c == '#':
            # This is safe even if new_string is empty
            new_string = new_string[:-1]
        else:
            new_string += c

    return new_string

def backspace_compare(str1: str, str2: str) -> bool:
    """Compare two strings are the same if '#' is a back space character

    Args:
        str1 (str): The first string
        str2 (str): The second string

    Returns:
        bool: Whether the resulting strings are the same
    """
    return covert_string(str1) == covert_string(str2)


def main():
    result = backspace_compare(sys.argv[1], sys.argv[2])
    print(result)


if __name__ == '__main__':
    main()
