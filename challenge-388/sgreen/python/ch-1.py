#!/usr/bin/env python3

"""Simon's solution to task 1 of The Weekly Challenge"""

import sys


def dyck_words(n: int, dyck: str | None = None) -> list[str]:
    """
    Return a list of all valid Dyck words of length 2 × n, sorted in
    lexicographical (alphabetical) order.

    Params:
        n (int): The target number of up and downs.

    Returns:
        list[str]: A list of all dyck words sorted alphabetically.
    """
    if dyck is None:
        # First call. The first move is always 'U' (Up)
        dyck = "U"

    if len(dyck) == 2 * n:
        # We have a solution if the length of the string is 2 × n.
        return [dyck]

    # Count how many more ups than downs in the string so far
    steps = dyck.count("U") - dyck.count("D")

    # All solutions from calling the recursive function
    solutions = []

    if steps > 0:
        # We're not at the bottom and can move down
        down = dyck_words(n, f"{dyck}D")
        if down:
            solutions.extend(down)
    if steps < 2 * n - len(dyck):
        # We can move up only if there are enough downs to match
        up = dyck_words(n, f"{dyck}U")
        if up:
            solutions.extend(up)

    return solutions


def main():
    """Convert command line input into parameters for the function and display result"""
    result = dyck_words(int(sys.argv[1]))
    print("(" + ", ".join(f'"{r}"' for r in result) + ")")


# Call main if run from the command line
if __name__ == "__main__":
    main()
