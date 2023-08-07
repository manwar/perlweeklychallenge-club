#!/usr/bin/env python3

import sys


def main(ints):
    # Get the minimum value
    moves = 0
    min_int = min(ints)

    while len(ints):
        moves += 1
        value = ints.pop(0)

        # If this is the minimum value, calculate the new minimum value
        if value == min_int:
            if len(ints):
                min_int = min(ints)
        else:
            # Move it to the end
            ints.append(value)

    print(moves)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
