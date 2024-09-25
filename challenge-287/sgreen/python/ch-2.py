#!/usr/bin/env python3

import re
import sys


def valid_number(s: str) -> bool:
    """Check if the given string is a valid number.

    Args:
        s (str): The supplied string.

    Returns:
        bool: True if the string is a valid number, False otherwise.
    """
    return bool(re.search(r'^[+-]?([0-9]+\.?[0-9]*|\.[0-9]+)([eE][+-]?[0-9]+)?$', s))


def main():
    result = valid_number(sys.argv[1])
    print('true' if result else 'false')


if __name__ == '__main__':
    main()
