#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge"""

import sys


def k_beauty(num: int, k: int) -> int:
    """
    Find the number of substrings of given number when it is read as a string
    has length of ‘k’ and is a divisor of given number.

    Params:
        num (int): The number
        k (int): The length of the divisor

    Returns:
        int: The number of substrings that are a divisor of the original number
    """
    # Convert num to a string
    s = str(num)

    # Compute all substrings of length 'k'
    count = 0
    for start in range(len(s) - k + 1):
        # If it is evenly divisible, increment the count value.
        if num % int(s[start:start+k]) == 0:
            count += 1

    return count


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = k_beauty(array[0], array[1])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
