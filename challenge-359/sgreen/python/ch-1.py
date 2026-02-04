#!/usr/bin/env python3

import sys


def get_digital_root(number: int) -> tuple[int, int]:
    """
    Calculates the persistence and digital root of a specified integer.

    Args:
        number (int): A positive integer.

    Returns:
        persistence (int): The number of iterations to get a single digit.
        digital_root (int): The digital root of the integer.
    """

    if number <= 0:
        raise ValueError("You must provide a positive integer")

    persistence = 0
    digital_root = number

    # Keep iterating until we have a single digital
    while len(str(digital_root)) > 1:
        digital_root = sum(map(int, (d for d in str(digital_root))))
        persistence += 1

    return persistence, digital_root


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    persistence, digital_root = get_digital_root(int(sys.argv[1]))
    print(f"Persistence  = {persistence}")
    print(f"Digital Root = {digital_root}")


if __name__ == "__main__":
    main()
