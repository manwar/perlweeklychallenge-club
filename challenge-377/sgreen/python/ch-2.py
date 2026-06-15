#!/usr/bin/env python3

"Simon's solution to task 2 of The Weekly Challenge"""

import sys
from itertools import combinations


def prefix_suffix(array: list[str]) -> int:
    return sum(
        1
        for str1, str2 in combinations(array, 2)
        if (str1.startswith(str2) and str1.endswith(str2)) or
           (str2.startswith(str1) and str2.endswith(str1))
    )


def main():
    """Convert command line input into parameters for the function and display result"""
    result = prefix_suffix(sys.argv[1:])
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
