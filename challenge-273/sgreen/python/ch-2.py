#!/usr/bin/env python3

import re
import sys


import re


def b_after_a(s: str) -> bool:
    """
    Checks if the string 's' contains the letter 'a' does not appear after a 'b'.

    Args:
        s (str): The input string to be checked.

    Returns:
        bool: True if the criteria is met, False otherwise.
    """
    return re.search(r'^[^b]*b[^a]*$', s) is not None


def main():
    result = b_after_a(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
