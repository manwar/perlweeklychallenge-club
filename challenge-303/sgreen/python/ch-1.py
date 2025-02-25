#!/usr/bin/env python3

import sys
from itertools import permutations


def three_digits_even(ints: list) -> list:
    """Generate a list of all three digit even numbers from the specified list.

    Args:
        ints (list): A list of integers

    Returns:
        list: A sorted list of three digit integers
    """

    # Sets store unique numbers
    solution = set()

    # Work through all the digit permutations
    for p in permutations(ints, 3):

        # Ignore odd numbers (last digit), or if the first digit is zero
        if p[-1] % 2 == 1 or p[0] == 0:
            continue

        # Combine the numbers and add it to the set
        number = int(''.join(map(str, p)))
        solution.update([number])

    return sorted(solution)


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = three_digits_even(array)
    print(result)


if __name__ == '__main__':
    main()
