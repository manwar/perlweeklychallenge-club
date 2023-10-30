#!/usr/bin/env python3

import sys


def main(ints):
    # Record all the loops we find
    loops = 0

    for first in range(len(ints)):
        loop = []
        pos = first

        while pos >= 0 and pos < len(ints) and ints[pos] is not None:
            loop.append(pos)

            # What is the next number
            next_pos = ints[pos]

            # Mark this position as used
            ints[pos] = None

            if next_pos in loop:
                # We have a loop
                loops += 1
                break

            # Continue with the next position
            pos = next_pos

    # Print the loops we found
    print(loops)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
