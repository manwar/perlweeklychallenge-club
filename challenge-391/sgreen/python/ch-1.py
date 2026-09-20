#!/usr/bin/env python3

"""Simon's solution to task 1 of The Weekly Challenge"""

import re
import sys
from statistics import median


def array_median(arr1: list[int], arr2: list[int]) -> float:
    """
    Return a median value of two sorted lists

    Params:
        arr1 (list[int]): The first list
        arr2 (list[int]): The second list

    Returns
        float: The median value
    """
    return median(arr1 + arr2)


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers
    arr1 = [int(i) for i in re.findall(r"\d+", sys.argv[1])]
    arr2 = [int(i) for i in re.findall(r"\d+", sys.argv[2])]
    result = array_median(arr1, arr2)
    print(float(result))


# Call main if run from the command line
if __name__ == "__main__":
    main()
