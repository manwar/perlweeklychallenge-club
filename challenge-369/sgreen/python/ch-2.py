#!/usr/bin/env python3

import sys

from more_itertools import grouper


def group_division(input_string: str, size: int, filler: str) -> list[str]:
    """
    Split a string into parts of size length, filling the last item if required.

    Params:
        input_string(str): The string to split
        size (int): The size of each chunk
        filler (str): The filler character

    Returns:
        list[str]: The list of split strings
    """
    result = []
    for g in grouper(input_string, size, fillvalue=filler):
        result.append("".join(g))
    return result


def main():
    result = group_division(sys.argv[1], int(sys.argv[2]), sys.argv[3])
    print(result)


if __name__ == "__main__":
    main()
