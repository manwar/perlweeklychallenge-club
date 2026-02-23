#!/usr/bin/env python3

import sys


def echo_chamber(input_string: str) -> str:
    """
    Transform the string based on the index position of each character
    (starting from 0). For each character at position i, repeat it i + 1 times

    Params:
        input_string(str): The input the string

    Returns:
        str: The transformed string
    """

    return ''.join(
        letter * pos
        for pos, letter in enumerate(input_string, start=1)
    )


def main():
    result = echo_chamber(sys.argv[1])
    print(result)


if __name__ == "__main__":
    main()
