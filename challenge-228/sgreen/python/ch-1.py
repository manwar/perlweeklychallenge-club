#!/usr/bin/env python3

import sys


def main(ints):
    # Get the frequency of all numbers
    freq = {}
    for i in ints:
        freq[i] = 1 + freq.get(i, 0)

    # Get the sum of all unique values
    solution = sum(i for i in freq if freq[i] == 1)
    print(solution)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
