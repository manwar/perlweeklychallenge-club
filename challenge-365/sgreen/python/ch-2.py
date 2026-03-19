#!/usr/bin/env python3

import re
import sys


def valid_token_counter(input_string: str) -> int:
    """
    Return the number of space-separated words that met a criteria

    Params:
        input_string(str): The string to parse

    Returns:
        int: The number of words that match the criteria
    """

    return sum(
        1 for word in input_string.split()
        if re.search(r'^[a-z]+(\-[a-z]+)?[!,\.]?$', word)
    )


def main():
    result = valid_token_counter(sys.argv[1])
    print(result)


if __name__ == "__main__":
    main()
