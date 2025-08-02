#!/usr/bin/env python3

import sys


def decompressed_list(ints: list) -> list:
    """
    Decompress a list of integers where each integer represents the number of times the next integer should be repeated.
    :param ints: List of integers
    :return: Decompressed list of integers
    """
    result = []
    for i in range(0, len(ints), 2):
        count = ints[i]
        value = ints[i + 1]
        result.extend([value] * count)
    return result


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = decompressed_list(array)
    print(result)


if __name__ == '__main__':
    main()
