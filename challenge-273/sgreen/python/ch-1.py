#!/usr/bin/env python3

from math import floor
import sys


def char_percentage(s: str, char: str) -> int:
    """
    Calculates the percentage of a given character in a string.

    Args:
        s (str): The input string.
        char (str): The character to be counted.

    Returns:
        int: The percentage of the character in the string.
    """
    return floor(s.count(char) / len(s) * 100 + 0.5)


def main():
    result = char_percentage(sys.argv[1], sys.argv[2])
    print(result)


if __name__ == '__main__':
    main()
