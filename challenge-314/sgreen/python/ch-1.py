#!/usr/bin/env python3

import sys
from typing import Generator


def all_same(strs: Generator[str]) -> bool:
    """Return if all items are the same

    Args:
        strs (generator): A list of strings to compare

    Returns:
        bool: Whether they are all the same
    """
    return len(set(strs)) == 1


def equal_strings(strs: list) -> int:
    """Find how many characters to remove to make all strings equal

    Args:
        strs (list): A list of strings to analyze.

    Returns:
        int: The number of character to remove, or -1 if no solution is found
    """
    # Find the length of the shortest string, and the total strings
    shortest_length = min(len(s) for s in strs)
    combined_length = sum(len(s) for s in strs)

    # Find the most common prefix of all strings
    for l in range(shortest_length, 0, -1):
        if all_same(s[0:l] for s in strs):
            # We have the answer. Return the characters NOT remaining
            return combined_length - len(strs) * l

    # The first character is not the same
    return -1


def main():
    result = equal_strings(sys.argv[1:])
    print(result)


if __name__ == '__main__':
    main()
