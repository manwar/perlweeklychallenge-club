#!/usr/bin/env python3

import re
import sys


def good_parser(input_string: str) -> str:
    """
    Script to interpret the given string using Goal Parser rules.

    Params:
        input_string(str): The string being transformed

    Returns:
        str: The transformed string
    """
    # Check the input is valid
    if not re.search(r'^(G|\(\)|\(al\))*$', input_string):
        raise ValueError("Unexpected input received")

    # Perform the transaction
    return input_string.replace('()', 'o').replace('(al)', 'al')


def main():
    result = good_parser(sys.argv[1])
    print(result)


if __name__ == "__main__":
    main()
