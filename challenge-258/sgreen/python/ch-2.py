#!/usr/bin/env python3

import sys


def sum_of_values(ints: list, k: int) -> int:
    total = 0

    for pos, value in enumerate(ints):
        # Count the number of ones in the position value
        if k == bin(pos).count('1'):
            # If it matches the 'k', add the value to the total
            total += value

    return total


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    k = array.pop()
    result = sum_of_values(array, k)
    print(result)


if __name__ == '__main__':
    main()
