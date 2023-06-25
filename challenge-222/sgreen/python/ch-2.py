#!/usr/bin/env python3
import sys


def main(ints):
    # Sort the list
    ints = sorted(ints)

    while len(ints) > 1:
        # Take the two highest values from the list
        y = ints.pop()
        x = ints.pop()

        if y != x:
            # Add difference to the list, and sort it
            ints = sorted([y-x, *ints])

    if ints:
        # Print the remaining number
        print(ints[0])
    else:
        # There are no numbers remaining
        print('0')


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
