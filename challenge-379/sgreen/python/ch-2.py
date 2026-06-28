#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge"""

import sys


def armstrong_sum(num: int, base: int) -> int:
    """
    Compute the integer armstrong sum

    """

    # Convert the number into digits in the specified base
    digits = []
    while True:
        i, j = divmod(num, base)
        digits.insert(0, j)

        if i == 0:
            break

        num = i

    # Compute the armstrong sum by calculating the sum of each digit to the
    #  power of the number of digits
    l = len(digits)
    return sum(digit ** l for digit in digits)


def armstrong_numbers(base: int, limit: int) -> list[int]:
    """
    Find all armstrong numbers less than limit in the specified base

    Params:
        base (int): The base to use
        limit (int): One more than the last integer to consider

    Returns:
        int: The armstrong sum
    """

    # Store the integers that are an Armstrong Number

    result_list = []
    for i in range(limit):
        # If the Armstrong Sum in the original number, add it to the list
        if armstrong_sum(i, base) == i:
            result_list.append(i)

    # Return the list
    return result_list


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = armstrong_numbers(*array)
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
