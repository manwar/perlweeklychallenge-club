#!/usr/bin/env python


def shortest_distance(s: str, char: str) -> list[int]:
    """
    Calculate the shortest distance to the specified character for each character in the string.

    Args:
    s (str): The input string.
    char (str): The character to find the distance to.

    Returns:
    list[int]: A list of distances for each character in the string.
    """
    positions = [i for i, c in enumerate(s) if c == char]
    return [min(abs(i - pos) for pos in positions) for i in range(len(s))]


# Tests
assert shortest_distance("loveleetcode", "e") == [3, 2, 1, 0, 1, 0, 0, 1, 2, 2, 1, 0]
assert shortest_distance("aaab", "b") == [3, 2, 1, 0]
