#!/usr/bin/env python3

from math import ceil, floor
import sys


def text_justifier(input_string: str, width: int) -> str:
    """
    Write a script to return the string that centers the text within that width using asterisks * as padding

    Args:
        input_string: The text that needs to be justified
        width: The desired width

    Returns:
        str: The text that is justified
"""

    string_len = len(input_string)
    if string_len >= width:
        # No change required
        return input_string

    # How many asterisks are needed on each side
    asterisks = (width-string_len) / 2
    output_string = "*" * floor(asterisks) + input_string + "*" * ceil(asterisks)

    return output_string


def main():
    result = text_justifier(sys.argv[1], int(sys.argv[2]))
    print(result)


if __name__ == "__main__":
    main()
