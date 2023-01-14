#!/usr/bin/env python3

import sys


def main(n):
    # Calculate the frequency of each 'integer'
    freq = {}
    for i in n:
        freq[i] = freq.get(i, 0)+1

    solution = 0
    for f in freq.values():
        # If a value appears more than once, calculate the number of
        #  combinations. This is the sum of 1 + ... + f-1.
        if f > 1:
            solution += f * (f-1)//2

    # Display the output
    print(solution)


if __name__ == '__main__':
    main(sys.argv[1:])
