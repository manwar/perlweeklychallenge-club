#!/usr/bin/env python3

import sys


def smaller_than_current(numbers: list) -> list:
    """For each number in the list, count how many numbers are smaller than it.

    Args:
        numbers: List of numbers.

    Returns:
        A list of counts, where each count corresponds to how many numbers in the
        input list are smaller than or equal to the number at that index.
    """
    solution = []

    for number in numbers:
        # Count how many numbers are smaller or equal than the current number.
        # Subtract one to exclude the current number itself.
        solution.append(sum(1 for n in numbers if n <= number) - 1)

    return solution


def main():
    # Convert input into numbers
    array = [float(n) for n in sys.argv[1:]]
    result = smaller_than_current(array)
    print(result)


if __name__ == '__main__':
    main()
