#!/usr/bin/env python3

import sys


def smaller_than_current(ints: list) -> list:
    """For each integer, how many integers are smaller than current one

    Args:
        ints (list): The input list of integers

    Returns:
        list: The output list of integers
    """
    return [sum(1 for j in ints if j < i) for i in ints]


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = smaller_than_current(array)
    print('(' + ', '.join(map(str, result)) + ')')


if __name__ == '__main__':
    main()
