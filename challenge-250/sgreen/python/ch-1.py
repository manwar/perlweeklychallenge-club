#!/usr/bin/env python3

import sys


def main(ints):
    solution = -1

    # Loop through each position
    for idx in range(len(ints)):
        # The index mod 10 is the value at this position
        if idx % 10 == ints[idx]:
            # We have the best solution, so no need to continue looping
            solution = idx
            break

    print(solution)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
