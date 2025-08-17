#!/usr/bin/env python3

import sys


def range_sum(ints: list, x: int, y: int) -> int:
    """Calculate the sum of a range in a list of integers.

    Args:
        ints (list): A list of integers.
        x (int): The starting index of the range (inclusive).
        y (int): The ending index of the range (inclusive).

    Returns:
        int: The sum of the integers from index x to index y (inclusive).
    """
    # Sanity checks for x and y
    if x < 0 or x >= len(ints):
        raise ValueError(f"x must be between 0 and {len(ints) - 1}, got {x}")
    if y < 0 or y >= len(ints):
        raise ValueError(f"y must be between 0 and {len(ints) - 1}, got {y}")
    if x > y:
        raise ValueError(
            f"x must be less than or equal to y, got x={x}, y={y}")

    # Return the sum of the range from x to y (inclusive)
    return sum(ints[x:y + 1])


def main():
    # Convert input into integers
    array = [int(n) for n in sys.argv[1:]]
    y = array.pop()  # Last element is y
    x = array.pop()  # Second last element is x
    result = range_sum(array, x, y)
    print(result)


if __name__ == '__main__':
    main()
