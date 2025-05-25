#!/usr/bin/env python3

import sys


def string_format(input_string: str, size: int) -> str:
    # Remove existing dashes
    input_string = input_string.replace("-", "")

    # The start value is the position of the first characters, so the remaining
    #  characters are a multiple of 'size'
    start = len(input_string) % size
    parts = []


    if start:
        # The first group will be smaller than the rest
        parts.append(input_string[0:start])

    for pos in range(start, len(input_string), size):
        # Group the remain characters by size.
        parts.append(input_string[pos:pos+size])

    return '-'.join(parts)

def main():
    result = string_format(sys.argv[1], int(sys.argv[2]))
    print(result)


if __name__ == '__main__':
    main()
