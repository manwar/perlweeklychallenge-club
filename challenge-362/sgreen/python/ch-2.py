#!/usr/bin/env python3

import sys

from num2words import num2words


def spellbound_sorting(ints: list[int]) -> list[int]:
    """
    Write a script to return a list of integers in English alphabetical order

    Params:
        ints (list[int]): The supplied integers

    Returns:
        list[int]: A integers sorted by their English spelling
    """

    return sorted(ints, key=num2words)


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = spellbound_sorting(array)
    print(result)


if __name__ == "__main__":
    main()
