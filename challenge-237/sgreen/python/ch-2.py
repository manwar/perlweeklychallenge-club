#!/usr/bin/env python3

import sys


def main(ints):
    sorted_ints = sorted(ints, reverse=True)
    count = 0

    for i in sorted_ints:
        # If there isn't a solution, exit the loop
        if min(ints) >= i:
            break

        # Find the position of the maximum value < i, and delete it
        m = max(j for j in ints if j < i)
        idx = ints.index(m)
        del ints[idx]

        count += 1

    # Print the solution
    print(count)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
