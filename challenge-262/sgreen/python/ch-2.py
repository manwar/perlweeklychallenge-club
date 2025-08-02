#!/usr/bin/env python3

import sys


def equal_div(ints: list, k: int) -> int:
    """Count the number of occurrences where two values are equal and the
    product of their position is divisible by k

    Args:
        ints (list): The input list
        k (int): An integer

    Returns:
        int: The number of occurrences
    """

    count = sum(1
                for i in range(len(ints)-1)
                for j in range(i+1, len(ints))
                if ints[i] == ints[j] and i * j % k == 0
                )

    return count


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    k = array.pop()
    result = equal_div(array, k)
    print(result)


if __name__ == '__main__':
    main()
