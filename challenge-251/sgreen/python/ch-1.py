#!/usr/bin/env python3

import sys


def main(ints):
    solution = 0
    half = len(ints) // 2

    # If we have an odd number of integers, use the middle value
    if len(ints) % 2 == 1:
        solution += ints[half]

    # Combine the concatenation of the remaining integers, starting with first
    #  and last, then second and second last, and so on.
    for i in range(half):
        solution += int(str(ints[i]) + str(ints[-1-i]))

    print(solution)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
