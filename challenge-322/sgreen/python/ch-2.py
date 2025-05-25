#!/usr/bin/env python3

import sys


def rank_array(ints: list) -> list:
    """Return an array of the ranks of each element in a list

    Args:
        ints (list): The input list

    Returns:
        list: The position (1-based) of each integer
    """
    # Generate a list of the sorted unique values.
    sorted_list = sorted(set(ints))

    # Return the position (1-based) of the each value.
    return [sorted_list.index(i)+1 for i in ints]


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    result = rank_array(array)
    print(result)


if __name__ == '__main__':
    main()
