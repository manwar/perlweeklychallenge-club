#!/usr/bin/env python3

import sys


def main(array):
    # Count the frequency of even numbers
    evens = {}
    for i in array:
        if i % 2 == 0:
            evens[i] = evens.get(i, 0) + 1

    if not evens:
        # If no evens, return -1
        print(-1)
    else:
        # Find the evens that occur most often
        m = max(evens.values())
        max_evens = [i for i, v in evens.items() if v == m]

        # The the minimum even that occurs most often
        min_max_evens = min(max_evens)
        print(min_max_evens)


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
