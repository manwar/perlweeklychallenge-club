#!/usr/bin/env python3

import sys


def maximum_count(ints: list) -> int:
    """Return the maximum between the number of positive and negative integers

    Args:
        ints (list): A list of integers

    Returns:
        int: The maximum
    """

    # Count the number of positive and negative integers
    pos_count = sum(1 for i in ints if i > 0)
    neg_count = sum(1 for i in ints if i < 0)

    # Return the maximum of these two values
    return max(pos_count, neg_count)

def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = maximum_count(array)
    print(result)


if __name__ == '__main__':
    main()
