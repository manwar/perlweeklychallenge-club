#!/usr/bin/env python3

"""Simon's solution to task 2 of The Weekly Challenge"""

import sys
from itertools import permutations


def secret_santa(people: int) -> int:
    """
    Return the total number of valid gift assignments where no employee
    receives the gift they originally bought.

    Params:
        people: The number of people involved

    Returns:
        int: The number of valid combinations
    """
    # Count the number of valid permutations
    count = 0

    # Go through each permutation
    for p in permutations(range(people)):
        # Only count it if they aren't giving a gift to themselves
        if not any(i == j for i, j in enumerate(p)):
            count += 1

    return count


def main():
    """Convert command line input into parameters for the function and display result"""
    result = secret_santa(int(sys.argv[1]))
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
