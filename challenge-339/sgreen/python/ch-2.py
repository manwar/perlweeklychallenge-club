#!/usr/bin/env python3

import sys


def peak_point(gains: list) -> int:
    """
    Calculate the highest altitude reached given a list of altitude gains.

    Args:
        gains (list): A list of integers representing altitude gains.

    Returns:
        int: The highest altitude reached.
    """
    current_altitude = 0
    peak = 0

    for gain in gains:
        current_altitude += gain
        if current_altitude > peak:
            peak = current_altitude

    return peak


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = peak_point(array)
    print(result)


if __name__ == '__main__':
    main()
