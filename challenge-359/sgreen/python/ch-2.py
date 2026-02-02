#!/usr/bin/env python3

import re
import sys


def string_reduction(input_string: str) -> str:
    """
    Remove all adjacent duplicate characters from the input string.

    Args:
        input_string (str): The input string to process.

    Returns:
        str: The processed string with adjacent duplicates removed.
    """

    while True:
        # Keep removing adjacent duplicates until none remain
        new_string = re.sub(r'(.)\1', '', input_string)
        if new_string == input_string:
            return new_string
        input_string = new_string


def main():
    result = string_reduction(sys.argv[1])
    print('"' + result + '"')


if __name__ == '__main__':
    main()
