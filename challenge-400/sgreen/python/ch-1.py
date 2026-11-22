#!/usr/bin/env python3

"""Simon's solution to task 1 of The Weekly Challenge"""

from collections import Counter
import sys


def largest_interval(num: int) -> int:
    greatest_interval = 1
    last_number = 0

    for i in range(num+1):
        if any(True for freq in Counter(str(i)).values() if freq > 1):
            continue

        diff = i - last_number
        if diff > greatest_interval:
            greatest_interval = diff
        last_number = i
    return greatest_interval


def main():
    """Convert command line input into parameters for the function and display result"""
    result = largest_interval(int(sys.argv[1]))
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
