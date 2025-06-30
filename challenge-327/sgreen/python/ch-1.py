#!/usr/bin/env python3

import sys


def missing_integers(ints: list) -> list[int]:
    """Find missing integers in a sequence.

    Args:
        ints (list): List of integers.

    Returns:
        list[int]: List of missing integers in the sequence.
    """

    return [i for i in range(1, len(ints) + 1) if i not in ints]


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = missing_integers(array)
    print(result)


if __name__ == '__main__':
    main()
