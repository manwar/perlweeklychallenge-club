#!/usr/bin/env python3

import re
import sys


def target_array(source: list, indices: list) -> list:
    """Write a script to create target array by insert at index $indices[i] the value $source[i].

    Args:
        source (list): The source values
        indices (list): The indices values

    Raises:
        ValueError: List are of different length, or indices are out of bounds.

    Returns:
        list: The resulting list
    """

    # Sanity check
    if len(source) != len(indices):
        raise ValueError("Lists are of different length")

    solution = []
    for i in range(len(source)):
        solution.insert(indices[i], source[i])

    return solution


def main():
    # Convert input into integers
    source = [int(i) for i in re.findall(r'\d+', sys.argv[1])]
    indices = [int(i) for i in re.findall(r'\d+', sys.argv[2])]
    result = target_array(source, indices)
    print('(' + ', '.join(map(str, result)) + ')')


if __name__ == '__main__':
    main()
