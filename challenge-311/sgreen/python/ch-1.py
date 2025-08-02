#!/usr/bin/env python3

import sys


def upper_lower(s: str) -> str:
    """Convert lower case to upper and upper case to lower in the given string

    Args:
        s (str): The string to convert

    Returns:
        str: The converted string
    """
    return s.swapcase()


def main():
    result = upper_lower(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
