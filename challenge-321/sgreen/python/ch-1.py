#!/usr/bin/env python3

from decimal import Decimal
import sys


def distinct_average(numbers: list) -> int:
    unique_averages = set()

    # Make sure the list is even
    if len(numbers) % 2 == 1:
        raise ValueError("You must provide an even number of numbers")

    # Sort the list, and convert to Decimal type.
    numbers = sorted(Decimal(i) for i in numbers)

    for idx in range(len(numbers)//2):
        # Calculate the unique sums for matching pairs
        unique_averages.add((numbers[idx] + numbers[-1-idx])/2)

    return len(unique_averages)


def main():
    # Convert input into integers
    array = [Decimal(n) for n in sys.argv[1:]]
    result = distinct_average(array)
    print(result)


if __name__ == '__main__':
    main()
