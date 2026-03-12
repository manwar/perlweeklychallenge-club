#!/usr/bin/env python3

import re
import sys


def replace_digits(m: re.Match) -> str:
    """Turn a number into a letter of the alphabet"""
    c = m.group(0)
    return chr(96 + int(c[:2]))


def decrypt_string(input_string: str) -> str:
    """
    Script that maps the given string to English lowercase characters following
    a set of rules

    Params:
        input_string(str): The string being transformed

    Returns:
        str: The transformed string
    """

    # Check the input is valid
    if not re.search(r'^(1\d#|2[0-6]#|\d)*$', input_string):
        raise ValueError("String not in expected format")

    # Perform the transaction
    return re.sub(r'(1\d#|2[0-6]#|\d)', replace_digits, input_string)


def main():
    result = decrypt_string(sys.argv[1])
    print(result)


if __name__ == "__main__":
    main()
