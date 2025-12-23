#!/usr/bin/env python3

import sys


def binary_prefix(nums: list) -> list:
    # Check all items are zero or one
    if any(type(n) != int or n not in (0, 1) for n in nums):
        raise ValueError("Input list must contain only 0s and 1s")

    current_binary = ''
    results = []

    for n in nums:
        # Add the next digit to the current binary number
        current_binary += str(n)

        # Check if the current binary number is divisible by 5
        results.append(int(current_binary, 2) % 5 == 0)

    # Return the list of results
    return results

def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = binary_prefix(array)
    print(result)


if __name__ == '__main__':
    main()
