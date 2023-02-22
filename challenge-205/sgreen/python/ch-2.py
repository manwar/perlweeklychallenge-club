#!/usr/bin/env python3

import sys


def main(n):
    # Remove non-unique values
    n = list(set(n))
    items = len(n)
    max = n[0] ^ n[1]

    # Work through each combination of two numbers
    for first in range(items-1):
        for second in range(first+1, items):
            xor_value = n[first] ^ n[second]
            if max < xor_value:
                # We have a new maximum value
                max = xor_value

    # Print the maximum value found
    print(max)


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
