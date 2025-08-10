#!/usr/bin/env python3

import sys


def straight_line(points: list[list[int]]) -> bool:
    """
    Check if all points lie on a straight line.

    Args:
        points (list[list[int]]): A list of points, where each point is represented as a list of two integers [x, y].

    Returns:
        bool: True if all points lie on a straight line, False otherwise.
    """

    # Check for a flat line (to avoid division by zero error)
    if all(points[0][1] == points[i][1] for i in range(1, len(points))):
        return True

    # Check for only some points being a flat line
    if any(points[0][1] == points[i][1] for i in range(1, len(points))):
        return False

    degrees = set(
        abs((points[0][0] - points[i][0]) / (points[0][1] - points[i][1]))
        for i in range(1, len(points))
    )

    return True if len(degrees) == 1 else False


def main():
    # Convert input into integers, and then into pairs of points
    array = [int(n) for n in sys.argv[1:]]
    points = [[array[i], array[i + 1]] for i in range(0, len(array), 2)]
    result = straight_line(points)
    print(result)


if __name__ == '__main__':
    main()
