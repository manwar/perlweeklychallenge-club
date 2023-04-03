#!/usr/bin/env python3

import sys


def main(array):
    score = 0

    # Get all unique numbers
    for i in set(array):
        # Calculate the sum of all numbers one less, the same or one more
        #  than the target
        this_score = sum(x for x in array if i-1 <= x <= i+1)

        # Record this score if it is larger
        if score < this_score:
            score = this_score

    print(score)


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
