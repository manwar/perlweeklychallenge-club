#!/usr/bin/env python3

import sys


def kolakoski_sequence(number: int) -> int:
    """Calculate the number of 1's in the Kolakoski sequence up to a given position.

    Args:
        number (int): The position in the Kolakoski sequence.

    Returns:
        int: The count of 1's in the sequence up to the given position.
    """
    return (number+1) // 2


def main():
    result = kolakoski_sequence(int(sys.argv[1]))
    print(result)


if __name__ == "__main__":
    main()
