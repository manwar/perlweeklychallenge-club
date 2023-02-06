#!/usr/bin/env python3

import sys


def main(n):
    # This stores the current widest (leftmost) valley
    solution = []

    for valley in range(len(n)):
        start = end = valley

        # Get the values to the left that are >= the previous value
        while start > 0 and n[start] <= n[start-1]:
            start -= 1

        # Get the values to the right that are >= the previous value
        while end < len(n)-1 and n[end] <= n[end+1]:
            end += 1

        # If the len of this solution is larger than the previous, it's a
        #  better solution
        if len(solution) < end-start:
            solution = n[start:end+1]

    print(*solution, sep=', ')


if __name__ == '__main__':
    # Turn the strings into integers
    n = [int(i) for i in sys.argv[1:]]
    main(n)
