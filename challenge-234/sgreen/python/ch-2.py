#!/usr/bin/env python3

import sys
from itertools import combinations


def main(ints):
    # Calculate the frequency of all integers
    freq = {}
    for i in ints:
        freq[i] = freq.get(i, 0) + 1

    if len(freq) < 3:
        print('0')
        return

    solutions = 0
    for c in combinations(freq, 3):
        i, j, k = c
        # The number of solutions of this combination the product of the frequencies
        solutions += freq[i] * freq[j] * freq[k]

    print(solutions)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
