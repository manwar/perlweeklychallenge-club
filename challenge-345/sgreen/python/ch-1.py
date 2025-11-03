#!/usr/bin/env python3

import sys


def peak_positions(ints: list[int]) -> list[int]:
    """Return list of positions of peaks in the input list.

    Args:
        ints (list[int]): List of integers to analyze.

    Returns:
        list[int]: List of indices where peaks are located.
    """
    peaks = []

    # Check first element
    if ints[0] > ints[1]:
        peaks.append(0)

    # Check middle elements
    for pos in range(1, len(ints) - 1):
        if ints[pos] > ints[pos - 1] and ints[pos] > ints[pos + 1]:
            peaks.append(pos)

    # Check last element
    if ints[-1] > ints[-2]:
        peaks.append(len(ints) - 1)

    # Return list of peak positions
    return peaks


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = peak_positions(array)
    print('(' + ', '.join(map(str, result)) + ')')


if __name__ == '__main__':
    main()
