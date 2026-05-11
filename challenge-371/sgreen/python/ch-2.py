#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge"""

import sys


def subset_equilibrium(nums: list[int]) -> list[list[int]]:
    """
    Find all subsets where the sum of elements equals the sum of their indices.

    Params:
        nums (list): A list of integers

    Returns:
        list[list[int]]: A list of subsets that match the criteria
    """
    # Store the result list
    results = []

    for bits in range(1, 2**len(nums)-1):
        # Compute these values for this subset of values
        digit_sum = 0
        pos_sum = 0
        result = []
        for pos, value in enumerate(nums):
            # Use bitwise operator to determine if we should consider this value
            if 2 ** pos & bits:
                digit_sum += value
                pos_sum += pos + 1
                result.append(value)

        if digit_sum == pos_sum and len(result) > 1:
            # This matches the criteria
            results.append(result)

    return results


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = subset_equilibrium(array)

    # Display the result as per the example
    if result:
        print(", ".join("(" + ", ".join(map(str, r)) + ")" for r in result))
    else:
        print("()")


# Call main if run from the command line
if __name__ == "__main__":
    main()
