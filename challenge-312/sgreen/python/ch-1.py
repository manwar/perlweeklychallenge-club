#!/usr/bin/env python3

import re
import string
import sys


def minimum_time(s: str) -> int:
    # Make sure we have valid input
    if not re.search('^[a-z]+$', s):
        raise ValueError('Invalid input')

    # Start with the time it takes to press each key
    seconds = len(s)

    # Get the position of each character, and prepend an 'a' (0) to the list
    positions = [string.ascii_lowercase.index(c) for c in s]
    positions.insert(0, 0)

    for i in range(1, len(positions)):
        # Work out the shortest way to move between the two characters
        diff = abs(positions[i-1] - positions[i])
        if diff > 13:
            diff = 26 - diff

        # Add this time to the seconds value
        seconds += diff

    return seconds


def main():
    result = minimum_time(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
