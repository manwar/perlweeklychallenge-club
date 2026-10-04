#!/usr/bin/env python3

"""Simon's solution to task 2 of The Weekly Challenge"""

import math
import re
import sys


def is_prime(n: int) -> bool:
    """Determine if the given integer is a prime"""
    for i in range(2, int(math.sqrt(n)) + 1):
        if n % i == 0:
            return False

    # One isn't a prime
    return n >= 2


def prime_step(word: str) -> int:
    """
    Calculate the absolute difference of the sum of the ASCII values of the
    characters in the string to the nearest prime number

    Params:
        word (str): A string containing only English alphabet characters

    Returns:
        int: The absolute difference between the sum of the ASCII values of the
        characters and the nearest prime.
    """
    # Check the input is valid
    if not re.search(r"^[A-Za-z]+$", word):
        raise ValueError("Input can only contain English letters")

    # Calculate the sum of all the letters
    target = sum(ord(char) for char in word)

    # Check if this is a prime number
    if is_prime(target):
        return 0

    diff = 1
    while True:
        # Check if the number diff less than or greater than the target is a
        #  prime
        if is_prime(target - diff) or is_prime(target + diff):
            return diff
        diff += 1


def main():
    """Convert command line input into parameters for the function and display result"""
    result = prime_step(sys.argv[1])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
