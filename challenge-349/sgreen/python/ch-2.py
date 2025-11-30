#!/usr/bin/env python3

from collections import Counter
import sys


def meeting_point(input_string: str) -> bool:
    """
    Determine if a series of moves returns to the starting point.

    Args:
        input_string (str): A string of moves consisting of 'U', 'D', 'L', 'R' (up, down, left and right).

    Returns:
        bool: True if the moves return to the starting point, False otherwise.
    """
    # Initialise position
    x, y = 0, 0

    for move in input_string:
        # Make the move
        if move == 'U':
            y += 1
        elif move == 'D':
            y -= 1
        elif move == 'L':
            x -= 1
        elif move == 'R':
            x += 1
        else:
            raise ValueError(f"Invalid move encountered: '{move}'")

        # If we are at the starting point, return True
        if x == 0 and y == 0:
            return True

    # We never returned to the starting point
    return False


def main():
    result = meeting_point(sys.argv[1])
    print(result)


if __name__ == '__main__':
    main()
