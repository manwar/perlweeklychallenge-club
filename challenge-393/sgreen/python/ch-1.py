#!/usr/bin/env python3

"""Simon's solution to task 1 of The Weekly Challenge"""

import math
import sys
from itertools import combinations


def is_valid_pythagoras(k: int | float, n: int) -> bool:
    """Return if k is an integer and <= n"""
    return k == int(k) and k <= n


def pythagoras_multiplied(n: int) -> int:
    """
    Return the number of all positive integer triplets (i, j, k) so that
    i² + j² = k² and i, j and k are integers <= n.

    Params:
        n: The supplied number

    Returns:
        int: The number of triplets that satisfy the criteria
    """
    return sum(
        2
        for i, j in combinations(range(1, 1 + n), 2)
        if is_valid_pythagoras(math.sqrt(i**2 + j**2), n)
    )


def main():
    """Convert command line input into parameters for the function and display result"""
    result = pythagoras_multiplied(int(sys.argv[1]))
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
