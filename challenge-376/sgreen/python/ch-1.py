#!/usr/bin/env python3

"Simon's solution to task 1 of The Weekly Challenge"""

import re
import sys


def is_black(cell: str) -> bool:
    """Determine if a square in a chessboard is black or white

    Params:
        cell (str): A square on the chess board in chess notation

    Returns:
        bool: If the square is black
    """
    # Check the cell is valid
    if not re.search('^[a-h][1-8]$', cell):
        raise ValueError(f"Cell {cell} is not valid!")

    return bool((cell[0] in "aceg") ^ (int(cell[1]) % 2))


def same_color(c1: str, c2: str) -> bool:
    """
    Find the given two coordinates have the same colour.

    Params:
        c1 (str): The location of the first square
        c2 (str): The location of the second square

    Returns:
        bool: If the two squares are the same colour
    """
    return is_black(c1) == is_black(c2)


def main():
    """Convert command line input into parameters for the function and display result"""
    result = same_color(sys.argv[1], sys.argv[2])
    print('true' if result else 'false')


# Call main if run from the command line
if __name__ == "__main__":
    main()
