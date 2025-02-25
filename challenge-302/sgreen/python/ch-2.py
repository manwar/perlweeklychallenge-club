#!/usr/bin/env python3

import sys


def step_by_step(ints: list) -> int:
    # Calculate the minimum running total
    min_value = ints[0]
    value = 0
    for i in ints:
        value += i
        if min_value > value:
            min_value = value

    if min_value >= 0:
        # No negative total found. Return the lowest positive integer
        return 1

    # Return the number to start with
    return 1 - min_value


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = step_by_step(array)
    print(result)


if __name__ == '__main__':
    main()
