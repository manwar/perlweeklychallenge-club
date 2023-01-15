#!/usr/bin/env python3

import sys
from itertools import combinations


def main(array):
    # Get the x, y, and z values from the input
    *array, x, y, z = array

    # The solution is the number of good triplets.
    count = 0

    # Work through all combinations of positions
    for c in combinations(range(len(array)), 3):
        i, j, k = sorted(c)
        # If we match the criteria, add one to the count
        if abs(array[i] - array[j]) <= x and \
                abs(array[j] - array[k]) <= y and \
                abs(array[i] - array[k]) <= z:
            count += 1

    # Display the output
    print(count)


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
