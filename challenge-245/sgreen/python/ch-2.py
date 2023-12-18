#!/usr/bin/env python3

from itertools import permutations
import sys


def largest_number(numbers):
    # Calculate the largest number using the all supplied numbers
    largest = 0
    for i in permutations(map(lambda x: str(x), numbers)):
        n = int(''.join(i))
        if n > largest:
            largest = n

    return largest


def main(ints):
    largest = -1
    for bitwise in range(1, 2 ** len(ints)):
        numbers = [n for i, n in enumerate(ints) if bitwise & (2 ** i)]
        if sum(numbers) % 3 != 0:
            # There is no possible solution with this set of numbers
            continue

        this_largest = largest_number(numbers)
        if this_largest > largest:
            largest = this_largest

    print(largest)


if __name__ == '__main__':
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    main(array)
