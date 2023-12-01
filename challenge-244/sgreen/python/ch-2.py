#!/usr/bin/env python3

import sys
from itertools import combinations


def calculate_power(numbers):
    '''Return the square of the maximum number multiplied by the smallest one'''
    min_int = min(numbers)
    max_int = max(numbers)
    return max_int ** 2 * min_int


def main(ints):
    power = 0
    for length in range(1, len(ints)+1):
        power += sum(calculate_power(c) for c in combinations(ints, length))

    print(power)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
