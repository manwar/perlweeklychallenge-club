#!/usr/bin/env python3

"""Simon's solution to task 1 of The Weekly Challenge"""

import re
import sys


def finishing_order(order: list[int], friends: list[int]) -> list[int]:
    # Validate input. Order contains 1 .. n
    if set(order) != set(range(1, len(order) + 1)):
        raise ValueError("The order list is invalid")
    # Friends is in increasing order
    if any(friends[i - 1] >= friends[i] for i in range(1, len(friends))):
        raise ValueError("The friends list is not increasing")

    # Return the order of the friends we want
    return [runner for runner in order if runner in friends]


def main():
    """Convert command line input into parameters for the function and display result"""
    # Convert input into integers
    order = [int(i) for i in re.findall(r"\d+", sys.argv[1])]
    friends = [int(i) for i in re.findall(r"\d+", sys.argv[2])]
    result = finishing_order(order, friends)
    print(result)


# Call main if run from the command line
if __name__ == "__main__":
    main()
