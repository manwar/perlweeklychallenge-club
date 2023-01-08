#!/usr/bin/env python3

import sys


def main(n):
    gap = 0     # The maximum gap
    count = 0   # Number of occurrences

    # Sort the list
    n = sorted(n)

    # Iterate through the list
    for i in range(len(n)-1):
        diff = n[i+1] - n[i]
        if diff > gap:
            # We have a new maximum, reset the count
            gap = diff
            count = 1
        elif diff == gap:
            # Add to the count
            count += 1

    # Display the result
    print(count)


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
